import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; // For accelerometer data
import 'package:camera/camera.dart'; // For camera functionality

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  bool _isDetecting = false;
  String _predictedLabel = "";
  double _acceleration = 0.0; // To track accelerometer data
  double _speed = 0.0; // Vehicle speed (mock for now, later from sensors)
  String _roadSignSpeedLimit = "60"; // Mocked road sign speed limit (replace with actual detection logic)

  // Smoothing variables for accelerometer data
  double _prevAcceleration = 0.0; // Previous acceleration
  static const double _accelerationThreshold = 5.0; // Threshold for crash detection
  bool _isCrashPopupVisible = false; // Flag to track crash popup visibility

  @override
  void initState() {
    super.initState();
    initializeCamera();
    initializeAccelerometer();
  }

  // Initialize camera
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    await cameraController?.initialize();

    // Start the image stream for road sign detection (not needed in this case, can be left as mock)
    cameraController?.startImageStream((CameraImage image) async {
      if (!_isDetecting) {
        _isDetecting = true;
        // Road sign detection is not done here, so no processing
        _isDetecting = false;
      }
    });
    setState(() {});
  }

  // Initialize the accelerometer
  void initializeAccelerometer() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate acceleration magnitude and apply smoothing
      double acceleration = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) - 9.8;
      double smoothedAcceleration = (acceleration + _prevAcceleration) / 2.0; // Smoothing filter
      setState(() {
        _acceleration = smoothedAcceleration;
        _prevAcceleration = smoothedAcceleration;
      });

      // Trigger crash detection based on acceleration threshold
      if (_acceleration > _accelerationThreshold && !_isCrashPopupVisible) { // Check if popup is already shown
        showCrashPopup();
      }
    });
  }

  // Show crash detection popup
  void showCrashPopup() {
    setState(() {
      _isCrashPopupVisible = true; // Set the flag to true
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.cyan.shade700,
          title: Text(
            "Crash Detected",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "The vehicle has experienced a significant impact.",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isCrashPopupVisible = false; // Reset the flag after closing the popup
                });
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.green.shade700),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show overspeeding popup
  void showOverspeedingPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade700,
          title: Text(
            "Overspeeding Warning",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "You are exceeding the speed limit of $_roadSignSpeedLimit km/h.",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.lightGreen.shade600),
              ),
            ),
          ],
        );
      },
    );
  }

  // Handle mock road sign speed limit detection (this could be improved with actual sign detection)
  void detectSpeedLimitFromCamera() {
    // This would normally be an ML model or other logic
    // For now, we'll just mock the detection based on the time
    setState(() {
      _roadSignSpeedLimit = (Random().nextInt(30) + 30).toString(); // Random speed limit between 30 and 60
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DriveSafe"),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: cameraController != null && cameraController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    )
                  : const CircularProgressIndicator(),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white.withOpacity(0.8),
                child: Text(
                  "Predicted Speed Limit: $_roadSignSpeedLimit km/h", // Display the mocked speed limit
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

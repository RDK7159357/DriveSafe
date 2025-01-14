import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; // For accelerometer and gyroscope
import 'package:geolocator/geolocator.dart'; // For GPS speed tracking
import 'package:camera/camera.dart'; // For camera functionality

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  bool _isDetecting = false;
  double _acceleration = 0.0; // Current acceleration
  double _speed = 0.0; // Current speed from GPS
  String _roadSignSpeedLimit = "60"; // Mock speed limit detection
  bool _isCrashPopupVisible = false;

  // Threshold values for realistic crash detection
  static const double _gForceThreshold = 8.0; // G-force threshold for crash
  static const double _speedThreshold = 20.0; // Minimum speed in m/s (72 km/h) for crash detection

  @override
  void initState() {
    super.initState();
    initializeCamera();
    initializeSensors();
    startGPS();
  }

  // Initialize the camera
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    await cameraController?.initialize();
    setState(() {});
  }

  // Initialize accelerometer and gyroscope for crash detection
  void initializeSensors() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate G-force
      double gForce = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) / 9.8;

      setState(() {
        _acceleration = gForce;
      });

      // Detect crash if thresholds are exceeded
      if (_acceleration > _gForceThreshold && _speed > _speedThreshold && !_isCrashPopupVisible) {
        showCrashPopup();
      }
    });
  }

  // Start GPS for speed tracking
  void startGPS() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _speed = position.speed; // Speed in m/s
      });
    });
  }

  // Show crash detection popup
  void showCrashPopup() {
    setState(() {
      _isCrashPopupVisible = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.cyan.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Crash Detected",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Significant impact detected at a speed of ${(_speed * 3.6).toStringAsFixed(1)} km/h.",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isCrashPopupVisible = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                  "Predicted Speed Limit: $_roadSignSpeedLimit km/h\nCurrent Speed: ${(_speed * 3.6).toStringAsFixed(1)} km/h",
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

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CameraDescription> cameras; // List of available cameras
  CameraController? cameraController; // Controller for the selected camera

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    // Get a list of available cameras
    cameras = await availableCameras();

    // Select the first available camera (usually the back camera)
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );

    // Initialize the controller
    await cameraController?.initialize();

    // Refresh the UI when the controller is ready
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Dispose the camera controller when no longer needed
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyan.shade50,
              Colors.lightGreen.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: cameraController != null && cameraController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: cameraController!.value.aspectRatio,
                    child: CameraPreview(cameraController!),
                  )
                : const CircularProgressIndicator(), // Show a loader while the camera initializes
          ),
        ),
      ),
    );
  }
}

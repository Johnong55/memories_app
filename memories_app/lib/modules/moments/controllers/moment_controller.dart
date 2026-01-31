import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../core/services/location_service.dart';
import '../views/camera_preview_screen.dart';

class MomentCameraController extends GetxController {
  final LocationService _locationService = Get.find<LocationService>();
  
  CameraController? cameraController;
  late List<CameraDescription> _cameras;
  
  // Observables
  final isCameraInitialized = false.obs;
  final isCapturing = false.obs;
  final flipRotation = 0.0.obs;
  final currentLocationName = Rxn<String>();
  final currentLatitude = Rxn<double>();
  final currentLongitude = Rxn<double>();
  final lastCapturedImage = Rxn<String>();
  
  int _selectedCameraIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
    _loadLocation();
  }
  
  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;
      
      _initController(_cameras[_selectedCameraIndex]);
    } catch (e) {
      Get.snackbar('Error', 'Camera init failed: $e');
    }
  }

  Future<void> _initController(CameraDescription description) async {
    final prevController = cameraController; // Keep reference to valid controller
    final newController = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: false,
    );
    
    cameraController = newController;

    try {
        await newController.initialize();
        // If we are disposing an old controller, do it after init of new one to avoid black screen flicker if possible?
        // Standard practice is usually dispose first. Let's stick to standard for now or simple swap.
        await prevController?.dispose();
    } catch (e) {
       print('Error initializing camera controller: $e');
    }

    if (newController.value.isInitialized) {
       isCameraInitialized.value = true;
    }
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    
    isCameraInitialized.value = false;
    flipRotation.value += 0.5; // Start rotation animation
    
    _selectedCameraIndex = (_selectedCameraIndex == 0) ? 1 : 0;
    
    await _initController(_cameras[_selectedCameraIndex]);
    
    flipRotation.value += 0.5; // End rotation animation
    isCameraInitialized.value = true;
  }

  Future<void> takePicture() async {
    if (isCapturing.value || cameraController == null || !cameraController!.value.isInitialized) return;

    try {
      isCapturing.value = true;
      HapticFeedback.mediumImpact();
      
      final XFile image = await cameraController!.takePicture();
      
      // Update location right before navigating to ensure freshness
      // await _loadLocation(); // Already periodic or one-off? Let's just trust current val or refresh it.
      
      Get.to(() => const CameraPreviewScreen(), arguments: {
        'imagePath': image.path,
        'latitude': currentLatitude.value ?? 0.0,
        'longitude': currentLongitude.value ?? 0.0,
        'locationName': currentLocationName.value ?? 'Unknown',
      });
      
    } catch (e) {
      Get.snackbar('Error', 'Capture failed: $e');
    } finally {
      isCapturing.value = false;
    }
  }

  Future<void> _loadLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;
      
      final name = await _locationService.getLocationName(position.latitude, position.longitude);
      currentLocationName.value = name;
    } catch (e) {
      print('Location error: $e');
      currentLocationName.value = "Unknown Location";
    }
  }
}

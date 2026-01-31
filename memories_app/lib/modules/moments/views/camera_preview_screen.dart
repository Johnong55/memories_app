import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late String imagePath;
  late double latitude;
  late double longitude;
  late String locationName;
  final TextEditingController _captionController = TextEditingController();
  final RxBool _isUploading = false.obs;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    imagePath = args['imagePath'];
    latitude = args['latitude'];
    longitude = args['longitude'];
    locationName = args['locationName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Full screen image
          Positioned.fill(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),

          // 2. Top bar (Close)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 30),
                        onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Bottom controls container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Location
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.deepPurple),
                            const SizedBox(width: 4),
                            Text(
                              locationName,
                              style: const TextStyle(
                                  color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Caption
                    TextField(
                      controller: _captionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add a caption...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Share Button
                    Obx(() => ElevatedButton(
                      onPressed: _isUploading.value ? null : _uploadMoment,
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.deepPurple,
                         foregroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isUploading.value
                          ? const SizedBox(
                                height: 20, width: 20, 
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Share Moment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadMoment() async {
    _isUploading.value = true;
    try {
        // Mock upload delay
        await Future.delayed(const Duration(seconds: 2));
        Get.back(); // Go back to camera
        Get.back(); // Go back to home (optional, or stay in camera)
        Get.snackbar('Success', 'Moment shared!');
    } catch(e) {
        Get.snackbar('Error', 'Failed to upload');
    } finally {
        _isUploading.value = false;
    }
  }
}

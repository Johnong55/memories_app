import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/moment_controller.dart';
// import '../../../routes/app_pages.dart';

class CameraScreen extends GetView<MomentCameraController> {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview
          Positioned.fill(
            child: Obx(() => controller.isCameraInitialized.value && controller.cameraController != null
                ? CameraPreview(controller.cameraController!)
                : const Center(child: CircularProgressIndicator())),
          ),
          
          // 2. Top Gradient
          Positioned(
            top: 0, left: 0, right: 0, height: 150,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
          ),
          
          // 3. Top Controls
          Positioned(
             top: 0, left: 0, right: 0,
             child: SafeArea(child: _buildTopBar()),
          ),
          
          // 4. Location Label
          Positioned(
            left: 0, right: 0, bottom: 140,
            child: _buildLocationLabel(),
          ),
          
          // 5. Bottom Gradient
          Positioned(
            bottom: 0, left: 0, right: 0, height: 180,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
          ),
          
          // 6. Bottom Controls
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: SafeArea(child: _buildBottomControls()),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildIconButton(icon: Icons.arrow_back, onTap: () => Get.back()),
              const SizedBox(width: 16),
              _buildIconButton(icon: Icons.settings, onTap: () {}),
            ],
          ),
          Row(
            children: [
              _buildGalleryThumbnail(),
              const SizedBox(width: 16),
              _buildIconButton(icon: Icons.more_vert, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildGalleryThumbnail() {
    return Obx(() {
       final lastImage = controller.lastCapturedImage.value;
       return GestureDetector(
        onTap: () {}, // TODO: Open Gallery
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[800],
            image: lastImage != null ? DecorationImage(image: NetworkImage(lastImage), fit: BoxFit.cover) : null,
          ),
        ),
      );
    });
  }

  Widget _buildLocationLabel() {
    return Obx(() {
      final location = controller.currentLocationName.value;
      if (location == null || location.isEmpty) return const SizedBox.shrink();
      
      return Center(
        child: GestureDetector(
          onTap: () => _showMapPreview(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomControls() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           _buildMapButton(),
           _buildCaptureButton(),
           _buildFlipButton(),
         ],
      ),
    );
  }
  
  Widget _buildMapButton() {
     return GestureDetector(
       onTap: () => _showMapPreview(),
       child: Container(
         width: 50, height: 50,
         decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.3),
           shape: BoxShape.circle,
         ),
         child: const Icon(Icons.location_on, color: Colors.white, size: 28),
       ),
     );
  }

  Widget _buildCaptureButton() {
    return GestureDetector(
      onTap: controller.takePicture,
      child: Obx(() => AnimatedScale(
        scale: controller.isCapturing.value ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ),
      )),
    );
  }

  Widget _buildFlipButton() {
    return GestureDetector(
      onTap: controller.switchCamera,
      child: Obx(() => AnimatedRotation(
        turns: controller.flipRotation.value,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 28),
        ),
      )),
    );
  }

  void _showMapPreview() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
           children: [
             Container(
               margin: const EdgeInsets.only(top: 8),
               width: 40, height: 4,
               decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
             ),
             Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Text(
                  controller.currentLocationName.value ?? 'Unknown',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
             ),
             Expanded(
               child: GoogleMap(
                 initialCameraPosition: CameraPosition(
                   target: LatLng(controller.currentLatitude.value ?? 0, controller.currentLongitude.value ?? 0),
                   zoom: 15,
                 ),
                 markers: {
                   Marker(
                     markerId: const MarkerId('current'),
                     position: LatLng(controller.currentLatitude.value ?? 0, controller.currentLongitude.value ?? 0),
                   ),
                 },
               ),
             ),
           ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

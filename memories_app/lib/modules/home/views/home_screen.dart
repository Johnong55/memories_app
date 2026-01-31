
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../../moments/controllers/moment_controller.dart';

class HomeScreen extends GetView<MomentCameraController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure camera is initialized if it wasn't already (though binding should handle it)
    // The controller's onInit calls _initializeCamera
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview Layer
          Positioned.fill(
            child: Obx(() {
              if (controller.isCameraInitialized.value && controller.cameraController != null) {
                 // Use CameraPreview with a transform if needed to fill screen properly
                 // For now, simpler CameraPreview implementation
                 return SizedBox(
                   width: Get.width,
                   height: Get.height,
                   child: CameraPreview(controller.cameraController!),
                 );
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }
            }),
          ),
          
          // 2. Top Gradient for visibility
          Positioned(
             top: 0, left: 0, right: 0, height: 160,
             child: Container(
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [
                     Colors.black.withOpacity(0.7),
                     Colors.transparent,
                   ],
                 ),
               ),
             ),
          ),

          // 3. Top Social Bar (Profile, Friends, Chat)
          Positioned(
            top: 50, // SafeArea top padding approx
            left: 0, 
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Icon
                  _buildCircleButton(
                    icon: Icons.person_outline, 
                    onTap: () {
                      // Navigate to Profile
                    }
                  ),
                  
                  // Friends Capsule
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: const [
                         Icon(Icons.people, color: Colors.white, size: 20),
                         SizedBox(width: 8),
                         Text(
                           "27 Friends", 
                           style: TextStyle(
                             color: Colors.white, 
                             fontWeight: FontWeight.bold,
                             fontSize: 16
                           )
                         ),
                      ],
                    ),
                  ),
                  
                  // Chat Icon
                  _buildCircleButton(
                    icon: Icons.chat_bubble_outline, 
                    onTap: () {
                      // Navigate to Chat
                    }
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom Controls Gradient
          Positioned(
             bottom: 0, left: 0, right: 0, height: 250,
             child: Container(
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.bottomCenter,
                   end: Alignment.topCenter,
                   colors: [
                     Colors.black.withOpacity(0.9),
                     Colors.black.withOpacity(0.4),
                     Colors.transparent,
                   ],
                 ),
               ),
             ),
          ),

          // 5. Main Camera Controls
          Positioned(
            bottom: 110, // Adjust based on Rollcall banner height
            left: 0, 
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     // Flash Button (Left)
                     IconButton(
                       onPressed: () {},
                       icon: const Icon(Icons.flash_off, color: Colors.white, size: 32),
                     ),
                     
                     // Shutter Button (Center)
                     GestureDetector(
                       onTap: controller.takePicture,
                       child: Container(
                         width: 84, height: 84,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: const Color(0xFFFFD700), width: 4), // Gold border
                           color: Colors.white.withOpacity(0.2), 
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(4.0),
                           child: Container(
                             decoration: const BoxDecoration(
                               shape: BoxShape.circle,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     ),
                     
                     // Flip Camera (Right)
                     IconButton(
                       onPressed: controller.switchCamera,
                       icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 32),
                     ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // History Label (Small yellow tag logic)
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(
                     color: const Color(0xFFFFD700), // Gold/Yellow color
                     borderRadius: BorderRadius.circular(12),
                   ),
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: const [
                       Text(
                         "6", // Badge count
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                       ),
                       SizedBox(width: 8),
                       Text(
                         "History",
                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                       ),
                       Icon(Icons.keyboard_arrow_down, size: 16),
                     ],
                   ),
                ),
              ],
            ),
          ),
          
          // 6. Rollcall Banner (Bottom)
          Positioned(
            bottom: 20,
            left: 16, 
            right: 16,
            child: Container(
               height: 70,
               padding: const EdgeInsets.symmetric(horizontal: 16),
               decoration: BoxDecoration(
                 color: const Color(0xFF1E1E1E),
                 borderRadius: BorderRadius.circular(24),
               ),
               child: Row(
                 children: [
                    // Thumbnail
                    Container(
                      width: 40, height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Place holder for image
                      child: const Icon(Icons.image, color: Colors.white54, size: 20),
                    ),
                    const SizedBox(width: 12),
                    
                    // Text
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                           Row(
                             children: [
                               Icon(Icons.campaign, color: Colors.white, size: 16),
                               SizedBox(width: 4),
                               Text(
                                 "Rollcall",
                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                               ),
                             ],
                           ),
                           Text(
                             "A friend shared!",
                             style: TextStyle(color: Colors.grey, fontSize: 13),
                           ),
                        ],
                      ),
                    ),
                    
                    // Action Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
                         color: const Color(0xFFFFD700).withOpacity(0.1),
                      ),
                      child: const Text(
                        "PICK YOURS",
                        style: TextStyle(
                          color: Color(0xFFFFD700), 
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                 ],
               ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
       onTap: onTap,
       child: Container(
         width: 48, height: 48,
         decoration: BoxDecoration(
           color: Colors.grey[900],
           shape: BoxShape.circle,
         ),
         child: Icon(icon, color: Colors.white, size: 24),
       ),
    );
  }
}

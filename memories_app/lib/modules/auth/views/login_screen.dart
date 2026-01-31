import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:memories_app/core/theme/app_theme.dart';

class LoginScreen extends GetView<void> { // We can change <void> to controller later
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get colors from theme or custom if needed to match design exactly
    // Design uses bg-background-light and dark:bg-background-dark
    // which we mapped in AppTheme.
    
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Hero Section (Masonry Grid)
            Expanded(
              flex: 6, // Adjust ratio as needed
              child: Stack(
                fit: StackFit.expand,
                children: [
                   const _MasonryGrid(),
                   // Gradient Overlay
                   Positioned(
                     bottom: 0,
                     left: 0,
                     right: 0,
                     height: 192, // h-48 = 12rem = 192px
                     child: DecoratedBox(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.bottomCenter,
                           end: Alignment.topCenter,
                           colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              Colors.transparent,
                           ],
                         ),
                       ),
                     ),
                   ),
                ],
              ),
            ),
            
            // Content & Action Section
            Expanded(
              flex: 4,
              child: SingleChildScrollView( // For small screens
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     // Headline
                     Text(
                       "Discover the World Through Friends",
                       textAlign: TextAlign.center,
                       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                         fontWeight: FontWeight.w800,
                         height: 1.1,
                         fontSize: 32,
                         color: Theme.of(context).colorScheme.onSurface,
                       ),
                     ),
                     const SizedBox(height: 12),
                     // Body Text
                     Text(
                       "Instantly share moments and find your next destination based on real experiences.",
                       textAlign: TextAlign.center,
                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                         color: const Color(0xFF637588), // Slate-500 equivalent, or adjust for dark mode logic
                         fontSize: 15,
                         fontWeight: FontWeight.w500,
                         height: 1.6,
                       ),
                     ),
                     const SizedBox(height: 32),
                     
                     // Buttons
                     _buildButtons(context),
                     
                     const SizedBox(height: 32),
                     
                     // Footer Login Link
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "Already have an account?",
                           style: TextStyle(
                             color: const Color(0xFF637588),
                             fontSize: 14,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         const SizedBox(width: 4),
                         GestureDetector(
                           onTap: () {
                             // Navigate safely
                             Get.toNamed('/login-form'); // Example route
                           },
                           child: Text(
                             "Log In",
                             style: TextStyle(
                               color: AppTheme.primaryColor,
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ],
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // Primary Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
             // shadow handled by elevation defaults or custom shadow in theme?
             // Theme has elevation 0, design has shadow-lg shadow-blue-500/20
             elevation: 4,
             shadowColor: AppTheme.primaryColor.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Get Started"),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 14),
        
        // Apple Button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999), 
             ),
            side: BorderSide(color: Colors.grey.withOpacity(0.3)),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Apple Logo SVG
               SvgPicture.string(
                '''<svg viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.74s2.57-.9 3.87-.75c.52.03 3.68.27 4.9 3.62-3.8 1.95-2.85 7.03 1.15 8.1-.87 2.25-1.99 3.73-4.05 5.66zM12.03 7.25c-.19-2.08 1.55-3.86 3.5-4.13.25 2.25-2.03 4.14-3.5 4.13z"></path></svg>''',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              Text(
                "Continue with Apple",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
         const SizedBox(height: 14),
         
        // Google Button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999), 
             ),
             side: BorderSide(color: Colors.grey.withOpacity(0.3)),
             backgroundColor: Theme.of(context).cardColor,
             foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               // Google Logo SVG (No ColorFilter to keep original colors)
               SvgPicture.string(
                '''<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"></path><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"></path><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"></path><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"></path></svg>''',
                 width: 20,
                 height: 20,
               ),
              const SizedBox(width: 10),
              Text(
                "Continue with Google",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MasonryGrid extends StatefulWidget {
  const _MasonryGrid();

  @override
  State<_MasonryGrid> createState() => _MasonryGridState();
}

class _MasonryGridState extends State<_MasonryGrid> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumn(
            [
              "https://lh3.googleusercontent.com/aida-public/AB6AXuBYiRHybbiZFXEk08K84GzUIcjup3moQl_0pAIttViYWjoGgsLM-vNNvm1kZerPdIpKPeXkEZTduFkVc87lGexEM_O1RsvziKTojPjtmv72ZtLCY2_3_bqHg7c1zKu0sw-AmPtTwNleXn-YudZ8Eft2vacgiBbPxk5rvBfwBc0B1i0nsjoclcjfKVM2MOP7nY28ULVBqfsTlTKyXfrJzoZpkUwEBLs5FvTR9WzyD_f5VPd-AMxSB06KJtsKClX5_F4x-cTD-5nPkwg",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuBLmvGyZKGhbnZy49MMGTGpQm3n75wHPec9PbcV5XCHEXxzj68qNP-D2NePJkLxzKoJSLthBZZdifuOaJrplrZ3WAYNikMhGzf9MFRgDEvWw5X-UT5gyqLTkyj_TJhY7dhHnOwL9vRc7KVj_TQ9vqLsQSKFN9t3MAXQo6k4Xzpb3HT6p0XbsRwBLJOLowQUH5AQuyNDnOmQP25SioFRRAWTRB_1TWMJLPaP-2r1kCz_N2lpUlRL4jDmsx7MPdM35qdiU7yuZUVJkAw",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCYIxoI2su3PM2I_dJi13yqL4YtgkH8LU1dMRUCo8rnBIi8LhRs3sBJ4zxmXR_RgTXT7h6TLv9n7ku2cVtYKOZf75SQN9iL59dbfBtFLn03HFUYqVcitEWiFCF2rtoAY-O-s_Wd0fJtjSBF8mcgiVA9-HnMFtWfL-3T3HyXShNWVwy27Lxuc5nB7at60HjgQJtVj5Q9Hij6aqn9OydoMs3I0DGq3-kNKoKQ1ip3xjXog0BHjuZv6xWKDJUUyGF5LDWO6NhlGJMCB5s",
            ],
            delay: 0,
            paddingTop: 0,
          ),
          const SizedBox(width: 12),
          _buildColumn(
            [
              "https://lh3.googleusercontent.com/aida-public/AB6AXuC52KGdHpKvSwVjkrB2yg5waSmueo-4556rFJD5vD32E0oHJj4-IGVOuLszqDajoE4gbDyHJ19CJN2w3C9xJzy4cFdENSRWbdSQ58-QddSMBJJRJaN0UMdEUgUTw9YLUGZjt1phfGxFc2l2D0AIsq1o7ThHRbVdeeXxpNhaZUGNeU-Hkwl7BB-7RRX1oHX0cOxAbF0Kc9Jhc4JYKv9qQL6RHgxY_24oSzMqFGhtVkILMem9cGn2hi2_njAnTHQVVtnan4jldqij4B0",
               "https://lh3.googleusercontent.com/aida-public/AB6AXuBD4v9LeMpVZnBBAig1oc5_KaRhCwtu5Wpf_kT7iPwNuL8rFdA4rZKR8WrVaI8KOiKhRN6EIlTXoDBnW9OPCFA4vHZjPNnx1NQOriJDWB3VDrC6Dlg7nrUWxpEZNuV5lKxYojlPRbniymsoWxbwDXpvUrtts0-YuSTPeFqvAGzjqq1T3oDDsZvSRR36MNRAkSn5mgpWSAV9jxoMgiB3eVcs38UvzcxuqRFmBpSq6m6pQNHdzr8DA4UigKwGXgKraGRQjGkQhdECXkw",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCUOfpPoDj-LeCjYPSHuMMM8YdFWRDuUQa3a3Db6SI22hjIYgFJBfMqCBLkcQLXnUYgiUKq-bsiAJ-decDjrBV9vdbibUkCqFKY7DLyKv4nXs78hzrJ0BbZNTCnk4vkpZd8NTPoNUMPfyo967q0Y1yuYSletDt0J9eTbFOq18kAz7FBh7nWxFrJfAWhhrVvIEmoBcXPPYiuCkCuypjF9H0virD0T1iDRWCdD-YsVu7Upwzutdy0h1xctV3JTpLybFPCBn_175UeBnU",
            ],
            delay: 200, // 0.2s lag
            paddingTop: 32, // Offset
          ),
          const SizedBox(width: 12),
           _buildColumn(
            [
              "https://lh3.googleusercontent.com/aida-public/AB6AXuB63BBPWAZO31Csf-plEmFcju6624t1ijpvqeJ7w_k9IPyOCYBypvZzic0k23S-sitFQ1lPUmqg9w5-XAWdgowcOT5a-sX0e9W3MS5o1DpLJ88bGhiuyOLHz6QQKjz5FuK-t25yFrDsLGLpUD2Kb0vZlXJJzpADu8q5ZhNPNBRJnvJURxXh5kt1ZY6uwdTH-FeS89ZQNoR2uSky6mXtTqYVcRAU7LlAJKznWUMCYjZRVPeJFDkihUFUs0VrqJW61PXfCNZt1rcqWT0",
               "https://lh3.googleusercontent.com/aida-public/AB6AXuArcl-hU-EmfIlN2yRFtqb76FEZdf9bQ25IvIJQhX6pbguKverOL2xNnzmCz_bpQXVkCT9gcUM14teOWCIvJx4liPNKmZn1MUEJm2kTLRHYH4bUdi_slYkUh6ESA6Xn27QS3atZagEtKP-GSHZdBSt32BhjYS2IwOxWBALTjMp3f7RE81pyRASkLsaz9q-To9ygyYaL3kUU8e1jFbSpLJANcTg921Jd86UmZAHVzP07iZU_5l66m7MsEHaX7FIzBLkc0Yt-PGX5M4k",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuB_6mfrQc1IeraXqArA8G7yIZc8Wmmnk27vF-cc_DxSH222Lru90Fg1VzlwcXstSlPKdZoU9_i-mg6wqk-UtxseRZXp25Di4ZTZu_lzz2blZYs-filoZuFEdoZFh-FfKID_GDJqf5B2sajJQyALoxJ2yCi0RZ-sfWIqQCBbIa-zue8K7MLRp9mC62up3F-L47nckx-isc0xMO6Nc3QzWxh_CZIbfsHEk1w_SNEx7SP2-fIk-K-lrr-E8yxQXXEWqJ9pQmQbguD9XgM",
            ],
            delay: 100, // 0.1s lag
             paddingTop: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(List<String> images, {required int delay, required double paddingTop}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: TweenAnimationBuilder<double>(
          // Delay handling by using a future inside or start time? 
          // Simpler: use the delay to offset the start.
          // Since all start at once, we can just use AnimatedOpacity + SlideTransition 
          // but let's just do a simple FadeInUp with AnimatedBuilder manually or a package.
          // Since I can't add animate_do right now easily, I'll use a Future delay in a StatefulWidget...
          // But wait, this is inside _MasonryGrid, so I can use separate builders.
          // Let's use a simpler approach: AnimatedOpacity/Padding with state initialized with delay.
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          builder: (context, value, child) {
             // We can simulate delay by checking value < epsilon but standard Tween starts immediately.
             // Let's just wrap in a widget that handles delay
             return _DelayedReveal(delay: delay, child: child!);
          },
          child: Column(
            children: images.map((url) => 
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: AspectRatio(
                  aspectRatio: 3/4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              )
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class _DelayedReveal extends StatefulWidget {
  final int delay;
  final Widget child;
  
  const _DelayedReveal({required this.delay, required this.child});
  
  @override
  State<_DelayedReveal> createState() => _DelayedRevealState();
}

class _DelayedRevealState extends State<_DelayedReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _offsetAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _offsetAnim,
        child: widget.child,
      ),
    );
  }
}

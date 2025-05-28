import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/onboarding_controller.dart';
import 'package:nomnom/app/modules/signup/views/signup_view.dart';
import 'package:nomnom/app/modules/signup/controllers/signup_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentData = controller.pages[controller.currentPage.value];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          color: currentData['color'],
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: controller.currentPage.value == index ? 60 : 20,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        key: ValueKey(controller.currentPage.value),
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentData['title'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${currentData['subtitle']} ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                                TextSpan(
                                  text: currentData['highlight'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Center(
                            child: Image.asset(
                              currentData['image'],
                              height: 220,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildNavigationButtons(currentData['color']),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(Color backgroundColor) {
    return Obx(() {
      int currentPageIndex = controller.currentPage.value;
      
      // Halaman 1 (index 0) - Arrow next di kiri
      if (currentPageIndex == 0) {
        return Row(
          children: [
            _buildArrowButton(
              icon: Icons.arrow_forward,
              onTap: () => controller.nextPage(),
            ),
            const Spacer(),
          ],
        );
      }
      
      // Halaman 2 (index 1) - Previous dan Next di kiri
      if (currentPageIndex == 1) {
        return Row(
          children: [
            Row(
              children: [
                _buildArrowButton(
                  icon: Icons.arrow_back,
                  onTap: () => controller.prevPage(),
                ),
                const SizedBox(width: 16),
                _buildArrowButton(
                  icon: Icons.arrow_forward,
                  onTap: () => controller.nextPage(),
                ),
              ],
            ),
            const Spacer(),
          ],
        );
      }
      
      // Halaman 3 (index 2) - Previous di kiri, Sign Up di kanan
      return Row(
        children: [
          _buildArrowButton(
            icon: Icons.arrow_back,
            onTap: () => controller.prevPage(),
          ),
          const Spacer(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: () {
                Get.put(SignUpController()); // inject controllernya dulu
                Get.to(() => SignUpView()); // lalu navigate
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                elevation: 8,
              ),
              child: Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildArrowButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.black54,
          size: 22,
        ),
      ),
    );
  }
}
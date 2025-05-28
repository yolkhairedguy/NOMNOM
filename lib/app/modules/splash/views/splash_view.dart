import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nomnom/app/styles/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {
  final SplashController controller = Get.put(SplashController());
  
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _buttonAnimationController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Logo animations
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.bounceOut,
    ));
    
    // Text animations
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOutBack,
    ));
    
    // Button animations
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _buttonScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.bounceOut,
    ));
    
    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeIn,
    ));
    
    // Start animations sequence
    _startAnimations();
  }
  
  void _startAnimations() async {
    // Logo animation first
    _logoAnimationController.forward();
    
    // Text animation after 600ms
    await Future.delayed(const Duration(milliseconds: 600));
    _textAnimationController.forward();
    
    // Button animation after another 400ms
    await Future.delayed(const Duration(milliseconds: 400));
    _buttonAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            
            // Animated Logo
            SlideTransition(
              position: _logoSlideAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Lottie.asset(
                    'assets/lottie/splash_logo.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 7),
            
            // Animated Tagline
            SlideTransition(
              position: _textSlideAnimation,
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: Text(
                  'Your tasty buddy, anytime!',
                  style: AppTextStyle.subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const Spacer(flex: 2),
            
            // Animated Get Started Button
Padding(
  padding: const EdgeInsets.only(bottom: 100, left: 70, right: 70),
  child: ScaleTransition(
    scale: _buttonScaleAnimation,
    child: FadeTransition(
      opacity: _buttonFadeAnimation,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.goToOnboarding(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF9CA24),
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            elevation: 6,
            shadowColor: const Color(0xFFF9CA24).withOpacity(0.3),
          ),
          child: Text(
            'Get Started',
            style: AppTextStyle.button,
          ),
        ),
      ),
    ),
  ),
),

            
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
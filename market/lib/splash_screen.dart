import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToHome();
  }

  void _initializeAnimations() {
    // Fade animation for the logo
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Scale animation for the logo
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Slide animation for the app name
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    // Rotation animation for decorative elements
    _rotateController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );

    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations sequentially
    _fadeController.forward().then((_) {
      _scaleController.forward();
    });
    _slideController.forward();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.go('/home_screen');
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1E),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated decorative circles - dark theme
            Positioned(
              top: -80,
              right: -60,
              child: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: Container(
                      width: 280.w,
                      height: 280.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00D4FF).withValues(alpha: 0.08),
                            Color(0xFF0099CC).withValues(alpha: 0.03),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00D4FF).withValues(alpha: 0.1),
                            blurRadius: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: -_rotateAnimation.value * 0.5,
                    child: Container(
                      width: 320.w,
                      height: 320.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF006E).withValues(alpha: 0.06),
                            Color(0xFFFB5607).withValues(alpha: 0.02),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF006E).withValues(alpha: 0.08),
                            blurRadius: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Main content
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with animations
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            width: 160.w,
                            height: 160.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF00D4FF),
                                  Color(0xFF0099CC),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00D4FF).withValues(alpha: 0.6),
                                  blurRadius: 50,
                                  spreadRadius: 8,
                                  offset: const Offset(0, 20),
                                ),
                                BoxShadow(
                                  color: Color(0xFF0099CC).withValues(alpha: 0.4),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/imgs/market.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.shopping_bag_rounded,
                                      size: 70.sp,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    // App name with slide animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              'Market',
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 2.0,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFF00D4FF).withValues(alpha: 0.6),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Container(
                              height: 4.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF00D4FF),
                                    Color(0xFFFF006E),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Text(
                              'Premium Shopping',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white.withValues(alpha: 0.8),
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Experience',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white.withValues(alpha: 0.6),
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 80.h),
                    // Modern loading indicator
                    _buildModernLoader(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernLoader() {
    return Column(
      children: [
        SizedBox(
          width: 80.w,
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final delay = index * 0.15;
                  final progress = (_pulseController.value - delay) % 1.0;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00D4FF),
                          Color(0xFFFF006E),
                        ],
                      ),
                      color: Color(0xFF00D4FF).withValues(
                        alpha: (progress < 0 ? 0.0 : progress).clamp(0.0, 1.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00D4FF).withValues(alpha: 0.7),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ),
        SizedBox(height: 22.h),
        Text(
          'Preparing your experience...',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 0.8,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

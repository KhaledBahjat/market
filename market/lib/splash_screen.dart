import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/features/auth/logic/auth_cubit/auth_cubit.dart';

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

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _initializeAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthCubit>().checkAuthState();
      }
    });
  }

  // =========================
  // Auth Navigation
  // =========================

  Future<void> _handleAuthState(AuthState state) async {
    if (_hasNavigated || !mounted) return;

    String? route;

    if (state is AuthAuthenticated) {
      route = AppRouts.homeScreen;
    } else if (state is AuthUnauthenticated) {
      route = AppRouts.signInScreen;
    }

    if (route == null) return;

    _hasNavigated = true;

    // نخلي الـ Splash يظهر بشكل محترم
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    context.go(route);
  }

  // =========================
  // Animations
  // =========================

  void _initializeAnimations() {
    // Fade
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // Scale
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.65,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOutBack,
      ),
    );

    // Slide
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Rotation
    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(
      CurvedAnimation(
        parent: _rotateController,
        curve: Curves.linear,
      ),
    );

    // Pulse
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.94,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    _fadeController.forward();

    await Future.delayed(
      const Duration(milliseconds: 150),
    );

    if (!mounted) return;

    _scaleController.forward();

    await Future.delayed(
      const Duration(milliseconds: 150),
    );

    if (!mounted) return;

    _slideController.forward();
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

  // =========================
  // Build
  // =========================

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        log('Splash received state: $state');

        _handleAuthState(state);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
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
              // =========================
              // Top Decorative Circle
              // =========================

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
                              const Color(0xFF00D4FF)
                                  .withValues(alpha: 0.08),
                              const Color(0xFF0099CC)
                                  .withValues(alpha: 0.03),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00D4FF)
                                  .withValues(alpha: 0.1),
                              blurRadius: 50,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =========================
              // Bottom Decorative Circle
              // =========================

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
                              const Color(0xFFFF006E)
                                  .withValues(alpha: 0.06),
                              const Color(0xFFFB5607)
                                  .withValues(alpha: 0.02),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF006E)
                                  .withValues(alpha: 0.08),
                              blurRadius: 50,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =========================
              // Main Content
              // =========================

              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // =========================
                      // Logo
                      // =========================

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
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF00D4FF),
                                    Color(0xFF0099CC),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00D4FF)
                                        .withValues(alpha: 0.6),
                                    blurRadius: 50,
                                    spreadRadius: 8,
                                    offset: const Offset(0, 20),
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF0099CC)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 25,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/imgs/market.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
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

                      // =========================
                      // App Name
                      // =========================

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
                                      color: const Color(0xFF00D4FF)
                                          .withValues(alpha: 0.6),
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
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF00D4FF),
                                      Color(0xFFFF006E),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),

                              SizedBox(height: 18.h),

                              Text(
                                'Premium Shopping',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white.withValues(
                                    alpha: 0.8,
                                  ),
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white.withValues(
                                    alpha: 0.6,
                                  ),
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 80.h),

                      // =========================
                      // Loader
                      // =========================

                      _buildModernLoader(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // Modern Loader
  // =========================

  Widget _buildModernLoader() {
    return Column(
      children: [
        SizedBox(
          width: 80.w,
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) {
                return AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final delay = index * 0.15;

                    final progress =
                        (_pulseController.value - delay) % 1.0;

                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00D4FF),
                            Color(0xFFFF006E),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00D4FF)
                                .withValues(alpha: 0.7),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Opacity(
                        opacity: progress.clamp(0.0, 1.0),
                        child: const SizedBox.expand(),
                      ),
                    );
                  },
                );
              },
            ),
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
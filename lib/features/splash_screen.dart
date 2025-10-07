import 'package:flutter/material.dart';
import 'package:mini_job_portal_demo/core/utils/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeParticles();
    _startSplashTimer();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    _colorAnimation = ColorTween(
      begin: const Color(0xFF0F1C2E),
      end: const Color(0xFF1A2C42),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  void _initializeParticles() {
    for (int i = 0; i < 15; i++) {
      _particles.add(Particle());
    }
  }

  void _startSplashTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        router.pushReplacement(AppRoutes.loginPage);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          body: SafeArea(
            child: Stack(
              children: [
                ..._particles.map((particle) {
                  return Positioned(
                    left: particle.x,
                    top: particle.y,
                    child: Opacity(
                      opacity: particle.opacity,
                      child: Container(
                        width: particle.size,
                        height: particle.size,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withValues(alpha: 0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.work_history,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // App Name with Gradient Text
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'CareerHub',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tagline
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Your Future Starts Here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.7),
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 80),

                      // Your Name in Elegant Container
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.15),
                                Colors.white.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Returaj Proshad Shornocar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),

                      // Animated Loading with Dots
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildAnimatedDot(0),
                            _buildAnimatedDot(1),
                            _buildAnimatedDot(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 200)),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}

class Particle {
  late double x;
  late double y;
  late double size;
  late double opacity;
  late double speed;

  Particle() {
    _reset();
  }

  void _reset() {
    x = (DateTime.now().millisecond % 400).toDouble();
    y = (DateTime.now().millisecond % 800).toDouble();
    size = (DateTime.now().millisecond % 10 + 2).toDouble();
    opacity = (DateTime.now().millisecond % 100) / 200.0;
    speed = (DateTime.now().millisecond % 3 + 1).toDouble();
  }

  void update() {
    y += speed;
    if (y > 800) {
      _reset();
      y = 0;
    }
  }
}

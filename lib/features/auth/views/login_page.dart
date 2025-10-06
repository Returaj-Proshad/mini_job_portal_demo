import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_job_portal_demo/core/utils/app_colors.dart';
import 'package:mini_job_portal_demo/core/utils/responsive.dart';
import '../state/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(loginStateProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);

    return Scaffold(
      backgroundColor: AppColors.errigalWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.responsive.symmetricPadding(
            horizontal: 30,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: context.responsive.fontSize(32),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              8.vs(context),

              Text(
                'Sign in to continue your job search',
                style: TextStyle(
                  fontSize: context.responsive.fontSize(16),
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),

              48.vs(context),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailField(),
                    24.vs(context),
                    _buildPasswordField(),
                    32.vs(context),
                    _buildLoginButton(loginState),
                  ],
                ),
              ),
              24.vs(context),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                  Padding(
                    padding: context.responsive.symmetricPadding(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: context.responsive.fontSize(14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                ],
              ),
              24.vs(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(icon: Icons.g_mobiledata, onTap: () {}),
                  16.hs(context),
                  _buildSocialButton(icon: Icons.apple, onTap: () {}),
                  16.hs(context),
                  _buildSocialButton(icon: Icons.facebook, onTap: () {}),
                ],
              ),
              40.vs(context),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: context.responsive.fontSize(14),
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: context.responsive.fontSize(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontSize: context.responsive.fontSize(14),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        8.vs(context),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: context.responsive.fontSize(16),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            contentPadding: context.responsive.symmetricPadding(
              vertical: 16,
              horizontal: 16,
            ),
            prefixIcon: Icon(
              Icons.email_rounded,
              color: Colors.grey[400],
              size: context.responsive.fontSize(20),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: context.responsive.fontSize(14),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        8.vs(context),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: context.responsive.fontSize(16),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            contentPadding: context.responsive.symmetricPadding(
              vertical: 16,
              horizontal: 16,
            ),
            prefixIcon: Icon(
              Icons.lock_rounded,
              color: Colors.grey[400],
              size: context.responsive.fontSize(20),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
                size: context.responsive.fontSize(20),
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onFieldSubmitted: (_) => _handleLogin(),
        ),
        12.vs(context),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: context.responsive.fontSize(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(AsyncValue<void> loginState) {
    final isLoading = loginState is AsyncLoading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: context.responsive.symmetricPadding(
            vertical: 16,
            horizontal: 24,
          ),
          shadowColor: Colors.transparent,
        ),
        child:
            isLoading
                ? SizedBox(
                  width: context.responsive.fontSize(20),
                  height: context.responsive.fontSize(20),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: context.responsive.fontSize(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.responsive.scaleWidth(60),
        height: context.responsive.scaleWidth(60),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[200]!, width: 1.5),
        ),
        child: Icon(
          icon,
          color: Colors.grey[600],
          size: context.responsive.fontSize(24),
        ),
      ),
    );
  }
}

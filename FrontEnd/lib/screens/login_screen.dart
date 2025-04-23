import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/ui_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Curved top with logo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: AppDimensions.paddingXL,
                  bottom: AppDimensions.paddingXXL,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppDimensions.radiusXXL),
                    bottomRight: Radius.circular(AppDimensions.radiusXXL),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Logo circle
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.travel_explore,
                          size: AppDimensions.iconXL,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    
                    // App name
                    Text(
                      'Travel Planner',
                      style: AppTextStyles.headingL.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    
                    // Tagline
                    Text(
                      'Your journey begins here',
                      style: AppTextStyles.bodyL.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppDimensions.paddingXL),
              
              // Login form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome text
                      Text(
                        'Welcome back',
                        style: AppTextStyles.headingM.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingS),
                      Text(
                        'Sign in to continue planning your trips',
                        style: AppTextStyles.bodyL.copyWith(
                          color: AppColors.mediumGrey,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      
                      // Error message
                      if (_errorMessage != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppDimensions.paddingM),
                          margin: const EdgeInsets.only(bottom: AppDimensions.paddingL),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: AppDimensions.iconM,
                              ),
                              const SizedBox(width: AppDimensions.paddingS),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: AppTextStyles.bodyM.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: AppDecorations.inputDecoration(
                          label: 'Email',
                          hint: 'Enter your email',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: AppDimensions.paddingL),
                      
                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        decoration: AppDecorations.inputDecoration(
                          label: 'Password',
                          hint: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.mediumGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
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
                        enabled: !_isLoading,
                        onFieldSubmitted: (_) => _login(),
                      ),
                      const SizedBox(height: AppDimensions.paddingS),
                      
                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _isLoading ? null : () {
                            // Implement forgot password functionality
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.bodyM.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingL),
                      
                      // Login button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: AppDecorations.primaryButtonStyle,
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'SIGN IN',
                                    style: AppTextStyles.buttonM.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(width: AppDimensions.paddingS),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: AppDimensions.iconS,
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      
                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.bodyM.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                          TextButton(
                            onPressed: _isLoading 
                                ? null 
                                : () => Navigator.of(context).pushNamed('/register'),
                            child: Text(
                              'Sign up',
                              style: AppTextStyles.bodyM.copyWith(
                                color: AppColors.primary,
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
      ),
    );
  }
} 
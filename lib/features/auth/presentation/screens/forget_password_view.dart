import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../managers/auth_cubit.dart';
import '../managers/auth_state.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
        ),
        title: Text("Forgot Password", style: AppStyles.roboto16Yellow400),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(AppImages.forgetPasswordImage),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Transform.scale(
                    scale: 0.8,
                    child: Image.asset(AppImages.emailIcon),
                  ),
                ),
                SizedBox(height: 18.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Reset link sent! Check your inbox."),
                          backgroundColor: Colors.green.withOpacity(0.8),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pop(context); // Go back to Login
                    } else if (state is ResetPasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red.withOpacity(0.8),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return PrimaryElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().resetPassword(emailController.text.trim());
                        }
                      },
                      child: Text("Verify Email", style: AppStyles.roboto20Dark400),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
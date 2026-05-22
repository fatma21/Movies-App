import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../../../profile/presentation/managers/profile_cubit.dart';
import '../managers/auth_cubit.dart';
import '../managers/auth_state.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 69.h,
          horizontal: 20.w
        ),
          child: Column(
            spacing: 17.h,
            children: [
              Image.asset(AppImages.logo,width: 121.w,height: 118.h,),
              SizedBox(height: 40.h,),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 17.h,
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      hintText: AppLocalizations.of(context)!.email,
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.emailIcon,),
                      ),
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: AppLocalizations.of(context)!.password,
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.passwordIcon,),
                      ),
                      suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: hidePassword?Transform.scale(
                            scale: 0.8,
                            child: Image.asset(AppImages.eyeIcon,),
                          ) :
                          Icon(Icons.remove_red_eye,color: Colors.white,)
                      ),
                      obscureText: hidePassword,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(double.infinity, 30.h),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
                        style: AppStyles.roboto14Yellow400,
                      ),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state)async {
                        if (state is LoginSuccess) {

                          final uid = FirebaseAuth.instance.currentUser!.uid;

                          await context.read<ProfileCubit>().getUserProfile(uid);

                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.homeScreen,
                            );
                          }
                        } else if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message, style: AppStyles.roboto14White400),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20.w),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor ,));
                        }

                        return PrimaryElevatedButton(
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: AppStyles.roboto20Dark400,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.donHaveAnAccount,style: AppStyles.roboto14White400),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signupScreen);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.createOne,
                      style: AppStyles.roboto14Yellow900,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.w
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Expanded(child: Divider(color: AppColors.primaryColor,)),
                    Text("OR",style: AppStyles.roboto15Yellow400,),
                    Expanded(child: Divider(color: AppColors.primaryColor,))
                  ],
                ),
              ),
              SizedBox(height: 6.h,),
              PrimaryElevatedButton(
                child: Row(
                  spacing: 12.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.googleIcon,width: 30.w,height: 30.h,),
                    Text(
                      AppLocalizations.of(context)!.loginWithGoogle,
                      style: AppStyles.roboto20Dark400,
                    ),
                  ],
                ),
                onPressed: () {
                  context.read<AuthCubit>().loginWithGoogle();
                },
              ),
            ],
          )
      ),
    );
  }
}

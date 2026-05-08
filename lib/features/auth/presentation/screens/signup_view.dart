import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../managers/auth_cubit.dart';
import '../managers/auth_state.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late PageController pageController;
  int currentPage = 1;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.45,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,)
        ),
        title: Text("Register",style: AppStyles.roboto16Yellow400,),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 18.h,
          horizontal: 18.w
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  spacing: 18.h,
                  children: [
                    SizedBox(
                      height: 161.h,
                      child: PageView.builder(
                      controller: pageController,
                      itemCount: avatars.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = currentPage == index ? 1.0: 0.5;
                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween(begin: scale, end: scale),
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(avatars[index]),
                              ),
                            );
                          },
                        );
                      },
                      ),
                    ),
                    Text("Avatar",style: AppStyles.roboto16White400,),
                    CustomTextFormField(
                      controller: nameController,
                      validator: AppValidators.validateRequired,
                      hintText: "Name",
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.nameIcon),
                      ),
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      validator: AppValidators.validateEmail,
                      hintText: "Email",
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.emailIcon),
                      ),
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      validator: AppValidators.validatePassword,
                      hintText: "Password",
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.passwordIcon),
                      ),
                      suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: hidePassword?Transform.scale(
                            scale: 0.8,
                            child: Image.asset(AppImages.eyeIcon),
                          ):Icon(Icons.remove_red_eye,color: Colors.white,)
                      ),
                      obscureText: hidePassword,
                    ),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value != passwordController.text) return "Passwords do not match";
                        return AppValidators.validateRequired(value);
                      },
                      hintText: "Confirm Password",
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.passwordIcon),
                      ),
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                          child: hideConfirmPassword?Transform.scale(
                            scale: 0.8,
                            child: Image.asset(AppImages.eyeIcon),
                          ) :Icon(Icons.remove_red_eye,color: Colors.white,)
                          ),
                      obscureText: hideConfirmPassword,
                    ),
                    CustomTextFormField(
                      controller: phoneController,
                      validator: AppValidators.validatePhone,
                      keyboardType: TextInputType.phone,
                      hintText: "Telephone Number",
                      prefixIcon: Transform.scale(
                        scale: 0.8,
                        child: Image.asset(AppImages.phoneIcon),
                      ),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          // Navigate to Home or show a success message
                          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                        } else if (state is RegisterError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message, style: AppStyles.roboto14White400),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20.w),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                          );
                        }
                      },
                      builder: (context,state){
                        if (state is RegisterLoading) {
                          return const Center(
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          );
                        }
                        return PrimaryElevatedButton(
                        child: Text(
                          "Create Account",
                          style: AppStyles.roboto20Dark400,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              avatar: avatars[currentPage],
                            );
                          }
                          else if (state is LoginError){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message, style: AppStyles.roboto14White400),
                                backgroundColor: Colors.red.withOpacity(0.8),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(20.w),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              ),
                            );
                          }
                          },
                      );},
                    ),
                  ]
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account ?",style: AppStyles.roboto14White400,
                    textAlign: TextAlign.end,),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.roboto14Yellow900,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

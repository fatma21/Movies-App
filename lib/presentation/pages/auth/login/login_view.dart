import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Image.asset(AppImages.emailIcon,width: 31.w,height: 25.h,),
              ),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Image.asset(AppImages.passwordIcon,width: 26.w,height: 30.h,),
                suffixIcon: Image.asset(AppImages.eyeIcon,width: 30.w,height: 30.h,),
                obscureText: true,
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
              PrimaryElevatedButton(
                child: Text(
                  AppLocalizations.of(context)!.login,
                style: AppStyles.roboto20Dark400,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                },
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
                    Text("OR"),
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
                },
              ),
            ],
          )
      ),
    );
  }
}

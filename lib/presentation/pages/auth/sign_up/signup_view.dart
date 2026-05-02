import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late PageController pageController;
  int currentPage = 1;
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
                hintText: "Name",
                prefixIcon: Image.asset(AppImages.nameIcon,width: 26.w,height: 30.h,),
              ),
              CustomTextFormField(
                hintText: "Email",
                prefixIcon: Image.asset(AppImages.passwordIcon,width: 26.w,height: 30.h,),
              ),
              CustomTextFormField(
                hintText: "Password",
                prefixIcon: Image.asset(AppImages.passwordIcon,width: 26.w,height: 30.h,),
                suffixIcon: Image.asset(AppImages.eyeIcon,width: 30.w,height: 30.h,),
                obscureText: true,
              ),
              CustomTextFormField(
                hintText: "Confirm Password",
                prefixIcon: Image.asset(AppImages.passwordIcon,width: 26.w,height: 30.h,),
                suffixIcon: Image.asset(AppImages.eyeIcon,width: 30.w,height: 30.h,),
                obscureText: true,
              ),
              CustomTextFormField(
                hintText: "Telephone Number",
                prefixIcon: Image.asset(AppImages.phoneIcon,width: 26.w,height: 30.h,),
              ),
              PrimaryElevatedButton(
                child: Text(
                  "Create Account",
                  style: AppStyles.roboto20Dark400,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.editProfileScreen);
                },
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
            ]
          ),
        ),
      ),
    );
  }
}

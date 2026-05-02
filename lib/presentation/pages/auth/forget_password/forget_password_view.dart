import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_images.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,)
        ),
        title: Text("Forgot Password",style: AppStyles.roboto16Yellow400,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 18.h,
            children: [
              Image.asset(AppImages.forgetPasswordImage),
              CustomTextFormField(
                hintText: "Email",
                prefixIcon: Image.asset(AppImages.passwordIcon,width: 26.w,height: 30.h,),
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
            ]
          ),
        ),
      )

    );
  }
}

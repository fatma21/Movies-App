import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const PrimaryElevatedButton({super.key,required this.child,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          minimumSize: Size(double.infinity,50.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15.h
          ),
          child: child,
        )
    );
  }
}

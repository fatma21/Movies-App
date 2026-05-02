import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class SecondaryElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  const SecondaryElevatedButton({super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        minimumSize: Size(double.infinity,50.h),
        side: BorderSide(color: AppColors.primaryColor,width: 1.w),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class GenderWidegt extends StatelessWidget {
  final String currentMovie;
  const GenderWidegt({super.key, required this.currentMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(12.r)
        ),
        child: Text(currentMovie,style: AppStyles.roboto16White400,textAlign: TextAlign.center,)
    );
  }
}

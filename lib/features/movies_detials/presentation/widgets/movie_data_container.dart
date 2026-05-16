import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class MovieDataContainer extends StatelessWidget {
  final IconData icon;
  final String data;
  const MovieDataContainer({super.key,required this.icon, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 22.w,
          vertical: 11.h
      ),
      decoration:BoxDecoration(
        color: AppColors.lightDarkColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        spacing: 18.w,
        children: [
          Icon(icon,color: AppColors.primaryColor,),
          Text(data.toString(),style: AppStyles.roboto24White700,)
        ],
      ),
    );
  }
}

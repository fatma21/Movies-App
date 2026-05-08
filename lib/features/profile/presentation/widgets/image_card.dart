import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final bool isSelected;
  const ImageCard({super.key,
    required this.image,
    this.isSelected =false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            shape: BoxShape.rectangle,
            color: isSelected ? AppColors.selected : Colors.transparent,
            border: Border.all(color: AppColors.primaryColor)
        ),
        height: 350.h,
        child: Image.asset(image)
    );
  }
}

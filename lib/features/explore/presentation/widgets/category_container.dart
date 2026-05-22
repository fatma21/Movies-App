import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class CategoryContainer extends StatelessWidget {
  final bool isSelected;
  final String category;
  const CategoryContainer({super.key,this.isSelected=false,required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected?AppColors.primaryColor:Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected?Colors.transparent:AppColors.primaryColor,width: 1)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          //vertical: 12.h,
          horizontal: 20.w
        ),
        child: Center(child: Text(category,style: isSelected?AppStyles.inter20DarkSemiBold:AppStyles.inter20Yellow600,)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/empty_list_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w
              ),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: "Search",
                    prefixIcon: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(AppImages.searchIcon),
                    ),
                  ),
                  EmptyListWidget(),
                ],
              )
          )
      ),
    );
  }
}

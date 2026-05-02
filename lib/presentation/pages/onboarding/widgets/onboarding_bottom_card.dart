import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/pages/onboarding/models/onboarding_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../../../../core/widgets/secondary_elevated_button.dart';
import '../manager/onboarding_cubit.dart';

class OnboardingBottomCard extends StatelessWidget {
  final OnboardingModel model;
  final int index;
  final PageController pageController;
  const OnboardingBottomCard({super.key,
  required this.model,
  required this.index,
    required this.pageController
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
        decoration: BoxDecoration(
            color: AppColors.darkColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          children: [
            Text(model.title, style: AppStyles.inter24WhiteBold,),
            Text(model.desc??"",style: AppStyles.inter20White400,textAlign: TextAlign.center,),
            SizedBox(height: 8.h),
            PrimaryElevatedButton(
                child: Text(
                  index == OnboardingModel.onboardingList.length - 1 ?
                  "Finish": "Next",style: AppStyles.inter20DarkSemiBold,),
                onPressed: () async{
                  if(index == OnboardingModel.onboardingList.length - 1) {
                    await CacheHelper.saveData(value: false);
                    Navigator.pushNamed(context,
                        AppRoutes.loginScreen);
                  }
                  else{
                    final cubit = context.read<OnboardingCubit>();
                    if (cubit.state < OnboardingModel.onboardingList.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                }
            ),
            index>1?SecondaryElevatedButton(
              onPressed: (){
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.h
                ),
                child: Text("Back",style: AppStyles.inter20Yellow600,),
              ),
            )
                :Container(),
          ],
        )
    );
  }
}

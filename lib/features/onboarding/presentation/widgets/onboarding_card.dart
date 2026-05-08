import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_bottom_card.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../../data/models/onboarding_model.dart';
import '../manager/onboarding_cubit.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel model;
  final PageController pageController;
  final int index;
  const OnboardingCard({
    super.key,
    required this.model,
    required this.pageController,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          model.image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        index == 0 ?
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16.h,
            children: [
              Text(
                model.title,
                style: AppStyles.inter36WhiteBold,
                textAlign: TextAlign.center,
              ),
              Text(
                model.desc!,
                style: AppStyles.inter20GrayRegular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              PrimaryElevatedButton(
                child: Text(
                  "Explore Now",
                  style: AppStyles.inter20DarkSemiBold,
                ),
                onPressed: () {
                  final cubit = context.read<OnboardingCubit>();
                  if (cubit.state < OnboardingModel.onboardingList.length - 1) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ): OnboardingBottomCard(model: model, index: index, pageController: pageController),
      ],
    );
  }
}

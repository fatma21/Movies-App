import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/pages/onboarding/manager/onboarding_cubit.dart';
import 'package:movies/presentation/pages/onboarding/widgets/onboarding_card.dart';
import 'models/onboarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, int>(
          builder: (context, currentIndex) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().updateIndex(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    itemBuilder: (context, index) {
                      return OnboardingCard(
                        model: OnboardingModel.onboardingList[index],
                        pageController: pageController,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
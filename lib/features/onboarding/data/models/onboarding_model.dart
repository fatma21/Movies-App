import '../../../../core/constants/app_images.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String? desc;

  OnboardingModel({
    required this.image,
    required this.title,
    this.desc,
  });

  static List<OnboardingModel> get onboardingList => [
    OnboardingModel(
      image: AppImages.onboarding1,
      title: "Find Your Favorite Movies",
      desc: "Explore a huge library of the latest cinematic masterpieces.",
    ),
    OnboardingModel(
      image: AppImages.onboarding2,
      title: "Create Your Watchlist",
      desc: "Save the movies you want to watch later in one place.",
    ),
    OnboardingModel(
      image: AppImages.onboarding3,
      title: "Enjoy Your Movie Night",
      desc: "Watch and share your favorite content with your friends.",
    ),
    OnboardingModel(
      image: AppImages.onboarding4,
      title: "Enjoy Your Movie Night",
      desc: "Watch and share your favorite content with your friends.",
    ),
    OnboardingModel(
      image: AppImages.onboarding5,
      title: "Enjoy Your Movie Night",
      desc: "Watch and share your favorite content with your friends.",
    ),
    OnboardingModel(
      image: AppImages.onboarding6,
      title: "Enjoy Your Movie Night",
      desc: "Watch and share your favorite content with your friends.",
    ),
  ];
}
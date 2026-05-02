import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/pages/auth/forget_password/forget_password_view.dart';
import 'package:movies/presentation/pages/auth/login/login_view.dart';
import 'package:movies/presentation/pages/auth/sign_up/signup_view.dart';
import 'package:movies/presentation/pages/home/home_view.dart';
import 'package:movies/presentation/pages/onboarding/onboarding_view.dart';
import 'package:movies/presentation/pages/profile/edit_profile.dart';
import 'core/constants/app_routes.dart';
import 'core/helpers/cache_helper.dart';
import 'core/localization/app_localizations.dart';
import 'core/manager/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isFirstTime = CacheHelper.getData(key: 'isFirstTime');
  runApp(
    BlocProvider(
      create: (context) => LocaleCubit(),
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key,required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, currentLocale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movies App',
              theme: ThemeData.dark(),
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routes: {
                AppRoutes.onBoardingScreen: (context) => const OnboardingView(),
                AppRoutes.loginScreen: (context) => const LoginView(),
                AppRoutes.signupScreen: (context) => const SignupView(),
                AppRoutes.forgetPasswordScreen: (context) => const ForgetPasswordView(),
                AppRoutes.homeScreen: (context) => HomeView(),
                AppRoutes.profileScreen: (context) => HomeView(),
                AppRoutes.editProfileScreen: (context) => EditProfile(),
              },
              home: isFirstTime ? const OnboardingView() : const LoginView(),
            );
          },
        );
      },
    );
  }
}
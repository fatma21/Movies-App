import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/features/auth/presentation/screens/forget_password_view.dart';
import 'package:movies/features/auth/presentation/screens/login_view.dart';
import 'package:movies/features/auth/presentation/screens/signup_view.dart';
import 'package:movies/features/layout/presentation/layout_view.dart';
import 'package:movies/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:movies/features/profile/presentation/views/edit_profile.dart';
import 'package:movies/features/profile/presentation/views/profile_view.dart';
import 'core/constants/app_routes.dart';
import 'core/helpers/cache_helper.dart';
import 'core/localization/app_localizations.dart';
import 'core/manager/locale_cubit.dart';
import 'features/auth/data/repository/auth_repo.dart';
import 'features/auth/presentation/managers/auth_cubit.dart';
import 'features/profile/data/data_sources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repo.dart';
import 'features/profile/presentation/managers/profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return BlocProvider(
            create: (context) => ProfileCubit(
              ProfileRepo(ProfileRemoteDataSource()),
            )..getUserProfile(FirebaseAuth.instance.currentUser!.uid),
      child: ScreenUtilInit(
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
                  AppRoutes.loginScreen: (context) => BlocProvider(
                    create: (context) => AuthCubit(AuthRepo()),
                    child: LoginView(),
                  ),
                  AppRoutes.signupScreen: (context) => BlocProvider(
                    create: (context) => AuthCubit(AuthRepo()),
                    child: const SignupView(),
                  ),                AppRoutes.forgetPasswordScreen: (context) => const ForgetPasswordView(),
                  AppRoutes.homeScreen: (context) => HomeView(),
                  AppRoutes.forgetPasswordScreen:(context) => BlocProvider(
                      create: (context)=>AuthCubit(AuthRepo()),
                      child: ForgetPasswordView(),
                  ),
                  AppRoutes.profileScreen: (context) => ProfileView(),
                  AppRoutes.editProfileScreen: (context) => EditProfile(),
                },
                home: isFirstTime ? const OnboardingView() : BlocProvider(
                  create: (context) => AuthCubit(AuthRepo()),
                  child: LoginView(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/core/models/movies_model.dart';
import 'core/constants/app_routes.dart';
import 'core/di/service_locator.dart';
import 'core/helpers/cache_helper.dart';
import 'core/localization/app_localizations.dart';
import 'core/manager/locale_cubit.dart';
import 'features/auth/data/repository/auth_repo.dart';
import 'features/auth/presentation/managers/auth_cubit.dart';
import 'features/auth/presentation/screens/login_view.dart';
import 'features/auth/presentation/screens/signup_view.dart';
import 'features/home/presentation/managers/home_cubit.dart';
import 'features/layout/presentation/screens/layout_view.dart';
import 'features/movies_detials/presentation/screens/movies_details_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_view.dart';
import 'features/profile/presentation/managers/profile_cubit.dart';
import 'features/profile/presentation/views/edit_profile.dart';
import 'features/profile/presentation/views/profile_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(MovieModelAdapter());
  Hive.registerAdapter(CastModelAdapter());

  await Hive.openBox('moviesBox');

  await Hive.openBox('userBox');

  await Hive.openBox<MovieModel>('wishlistBox');

  await Hive.openBox<MovieModel>('historyBox');

  await Hive.openBox<List>('exploreBox');

  await CacheHelper.init();

  await setupLocator();

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(
          create: (context) => sl<ProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
        ),

      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = CacheHelper.getData(key: 'isFirstTime') ?? true;

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, currentLocale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
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
                ),
                AppRoutes.homeScreen: (context) => const HomeView(),
                AppRoutes.profileScreen: (context) => const ProfileView(),
                AppRoutes.editProfileScreen: (context) => EditProfile(),
                AppRoutes.moviesDetailsScreen: (context) {
                  final args = ModalRoute.of(context)!.settings.arguments as MovieModel;
                  return MoviesDetailsScreen(movie: args,);
                },
              },
              home: isFirstTime
                  ? const OnboardingView()
                  : FirebaseAuth.instance.currentUser != null
                  ? const HomeView()
                  : BlocProvider(
                create: (context) => AuthCubit(AuthRepo()),
                child: LoginView(),
              ),
            );
          },
        );
      },
    );
  }
}
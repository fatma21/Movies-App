import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/features/explore/presentation/screens/explore_screen.dart';
import 'package:movies/features/search/presentation/screens/search_screen.dart';
import '../../../../core/constants/app_images.dart';
import '../../../home/presentation/managers/home_cubit.dart';
import '../../../home/presentation/screens/home_view.dart';
import '../../../profile/presentation/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeTab(),
    const SearchScreen(),
    ExploreScreen(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: screens,
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF282A28),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(AppImages.homeIcon, 0),
                buildNavItem(AppImages.searchIcon, 1),
                buildNavItem(AppImages.exploreIcon, 2),
                buildNavItem(AppImages.profileIcon, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(String icon, int index) {
    bool isSelected = currentIndex == index;
    return IconButton(
      onPressed: () {
        if(index == 0 && currentIndex != 0){
          context.read<HomeCubit>().fetchChangingGenreMovies();
          context.read<HomeCubit>().fetchHomeMovies();
        }
        setState(() {
          currentIndex = index;
        });
      },
      icon: Image.asset(
        icon,
        width: 24.w,
        height: 24.h,
        color: isSelected ? const Color(0xFFFFBB3B) : Colors.white,
      ),
    );
  }
}
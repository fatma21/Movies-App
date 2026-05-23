import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_styles.dart';
import 'package:movies/core/widgets/movie_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../managers/home_cubit.dart';
import '../managers/home_state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PageController _pageController = PageController(
    viewportFraction: 0.50,
    initialPage: 0,
  );
  int currentSlide=0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchHomeMovies();
      context.read<HomeCubit>().fetchChangingGenreMovies();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                      height: 900.h,
                      child: const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)));
                } else if (state is HomeError) {
                  return Center(child: Text(state.message,style: AppStyles.roboto20White400,));
                } else if (state is HomeSuccess) {
                  final movies = state.recentlyAddedMovies;
                  return Stack(
                      children: [
                        Container(
                          height: 550.h,
                          width: double.infinity,
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.darkColor.withAlpha(180),
                                AppColors.darkColor.withAlpha(160),
                                AppColors.darkColor,
                              ],
                            ),
                          ),
                          child: Image.network(
                            movies.isNotEmpty
                                ? movies[currentSlide % movies.length].largeCoverImage
                                : "",
                            fit: BoxFit.cover,
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Column(
                            children: [
                              Image.asset(AppImages.availableNow),
                              SizedBox(
                                  height: 351.h,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: state.genreMovies.length,
                                    onPageChanged: (index) =>
                                        setState(() => currentSlide = index),
                                    itemBuilder: (context, index) {
                                      if (movies.isEmpty) return const SizedBox();
                                      final movie = movies[index % movies.length];
                                      double scale = currentSlide == index
                                          ? 1.0
                                          : 0.8;
                                      return TweenAnimationBuilder(
                                        duration: const Duration(
                                            milliseconds: 300),
                                        curve: Curves.easeOut,
                                        tween: Tween<double>(
                                            begin: scale, end: scale),
                                        builder: (context, value, child) {
                                          return Transform.scale(
                                            scale: value,
                                            child: MovieCard(
                                              imageUrl: movie.largeCoverImage,
                                              rate: movie.rating.toString(),
                                              movie: movie,
                                              cardHeight: 351,
                                              cardWidth: 234,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )

                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 38.w
                                ),
                                child: Image.asset(AppImages.watchNow),
                              ),
                            ],
                          ),
                        )
                      ]
                  );
                }
                return const SizedBox();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w
              ),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeGenderError) {
                    return Center(
                      child: Text(state.message,style: AppStyles.roboto20White400,),
                    );
                  }

                  if (state is HomeSuccess) {
                    return Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              state.selectedGenre,
                              style: AppStyles.roboto20White400,
                            ),

                            TextButton(
                              onPressed: () {},

                              child: Row(
                                children: [
                                  Text(
                                    "See More",
                                    style: AppStyles.roboto16Yellow400,
                                  ),

                                  Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 220.h,

                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,

                            itemCount: state.genreMovies.length,

                            itemBuilder: (context, index) {
                              final movie = state.genreMovies[index];

                              return MovieCard(
                                imageUrl: movie.largeCoverImage,
                                rate: movie.rating.toString(),
                                movie: movie,
                              );
                            },

                            separatorBuilder: (context, index) {
                              return SizedBox(width: 16.w);
                            },
                          ),
                        ),

                        SizedBox(height: 100.h),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              )
            )
          ],
        ),
      ),
    );
  }
}

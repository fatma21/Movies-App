import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_styles.dart';
import 'package:movies/core/models/movies_model.dart';
import 'package:movies/features/movies_detials/presentation/widgets/gender_widegt.dart';
import 'package:movies/features/movies_detials/presentation/widgets/movie_data_container.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../profile/presentation/managers/profile_cubit.dart';
import '../../../profile/presentation/managers/profile_state.dart';
import '../managers/details_cubit.dart';
import '../managers/details_states.dart';

class MoviesDetailsScreen extends StatelessWidget {
  final MovieModel movie;
  const MoviesDetailsScreen({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    if (movie.id != 0) {
      context.read<ProfileCubit>().addMovieToHistory(
        uid: FirebaseAuth.instance.currentUser!.uid,
        movieId: movie.id.toString(),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {

            MovieModel currentMovie = movie;

            if (state is DetailsSuccess) {
              currentMovie = state.movie;
            }
            return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
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
                      currentMovie.largeCoverImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 22.w, left: 22.w, top: 29.h),
                    child: Column(
                      spacing: 180.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                            BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, profileState) {

                                final wishlist =
                                    profileState.user?.wishlist ?? [];

                                final isSaved = wishlist.contains(
                                  currentMovie.id.toString(),
                                );

                                return IconButton(
                                  onPressed: () {
                                    context.read<ProfileCubit>().toggleWishlist(
                                      uid: FirebaseAuth.instance.currentUser!.uid,
                                      movieId: currentMovie.id.toString(),
                                    );
                                  },
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: Image.asset(AppImages.saveIcon),
                                  // ),
                                  icon: Icon(
                                    isSaved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColors.primaryColor,
                                    size: 30.sp,
                                  ),
                                );
                              },
                            ),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Image.asset(AppImages.saveIcon),
                            // ),
                          ],
                        ),
                        Image.asset(AppImages.playIcon),
                        Text(currentMovie.title, style: AppStyles.roboto24White700),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(currentMovie.year.toString(), style: AppStyles.roboto20Gray700,textAlign: TextAlign.center,),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("Watch", style: AppStyles.roboto20White400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieDataContainer(icon: Icons.favorite, data: "15"),
                        MovieDataContainer(
                          icon: Icons.access_time_filled_sharp,
                          data: currentMovie.runtime.toString(),
                        ),
                        MovieDataContainer(
                          icon: Icons.star,
                          data: currentMovie.rating.toString(),
                        ),
                      ],
                    ),
                    Text("Screen Shots", style: AppStyles.roboto24White700),
                    state is DetailsLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ):
                    (currentMovie.screenshots == null ||
                        currentMovie.screenshots!.isEmpty)
                        ? Text(
                      "There is no screenshots",
                      style: AppStyles.roboto24White700,
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentMovie.screenshots!.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          currentMovie.screenshots![index],
                          fit: BoxFit.cover,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 13.h);
                      },
                    ),
                    Text("Similar", style: AppStyles.roboto24White700),
                    BlocBuilder<DetailsCubit, DetailsState>(
                      builder: (context, state) {
                        if (state is DetailsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          );
                        }
        
                        if (state is DetailsSuccess) {
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: state.similarMovies.length,
                            itemBuilder: (context, index) {
                              final similarMovie = state.similarMovies[index];
                              return MovieCard(
                                imageUrl: similarMovie.largeCoverImage.isNotEmpty
                                    ? similarMovie.largeCoverImage
                                    : similarMovie.mediumCoverImage,
                                rate: similarMovie.rating.toString(),
                                movie: similarMovie,
                                cardHeight: 279,
                                cardWidth: 189,
                              );
                            },
                          );
                        }
        
                        if (state is DetailsError) {
                          return Center(
                            child: Text(state.message, style: AppStyles.roboto20Gray700),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    Text("Summary", style: AppStyles.roboto24White700),
                    Text(currentMovie.summary, style: AppStyles.roboto16White400),
                    Text("Cast", style: AppStyles.roboto24White700),
                    state is DetailsLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ):
                    (currentMovie.cast == null || currentMovie.cast!.isEmpty)? Text("There is no cast", style: AppStyles.roboto24White700):
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentMovie.cast!.length,
                      itemBuilder: (context, index) {
                        final cast = currentMovie.cast![index];
                        return Container(
                              padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 11.h),
                              decoration: BoxDecoration(
                                color: AppColors.darkGrayColor,
                                borderRadius: BorderRadius.circular(20.r)
                              ),
                              child: Row(
                                spacing: 8.w,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: cast.urlSmallImage != null &&
                                        cast.urlSmallImage!.isNotEmpty
                                        ? Image.network(
                                      cast.urlSmallImage!,
                                      width: 70.w,
                                      height: 70.h,
                                      fit: BoxFit.cover,
                                    )
                                        : Container(
                                      width: 70.w,
                                      height: 70.h,
                                      color: Colors.grey,
                                      child: const Icon(Icons.person, color: Colors.white),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name : ${cast.name}", style: AppStyles.roboto16White400),
                                      Text("Character : ${cast.characterName}", style: AppStyles.roboto16White400)
                                    ],
                                  )
                                ],
                              ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 13.h);
                      },
                    ),
                    Text("Genres", style: AppStyles.roboto24White700),
                    SizedBox(
                      height: 150.h,
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            mainAxisSpacing: 11.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 2.8,
                          ),
                          itemCount: currentMovie.genres.length,
                          itemBuilder: (context,index){
                            return GenderWidegt(currentMovie: currentMovie.genres[index]);
                          }),
                    ),
                    SizedBox(height:20.h)
                  ],
                ),
              ),
            ],
          ),
        );
          }
      )
    );
  }
}

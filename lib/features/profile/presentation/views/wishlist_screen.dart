import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../auth/data/models/user.dart';
import '../managers/profile_cubit.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<ProfileCubit>();

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: AppColors.darkColor,

      body: StreamBuilder<MyUserModel>(
        stream:
        cubit.profileRepo.streamUserData(uid),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: AppStyles.roboto20White400,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const EmptyListWidget();
          }

          final wishlist =
              snapshot.data!.wishlist;

          if (wishlist.isEmpty) {
            return Center(child: const EmptyListWidget());
          }

          return FutureBuilder(
            future:
            cubit.getWishlistMovies(wishlist),

            builder: (context, moviesSnapshot) {

              if (moviesSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (moviesSnapshot.hasError) {
                return Center(
                  child: Text(
                    moviesSnapshot.error.toString(),
                    style: AppStyles.roboto20White400,
                  ),
                );
              }

              final movies =
                  moviesSnapshot.data ?? [];

              if (movies.isEmpty) {
                return Center(child: const EmptyListWidget());
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),

                child: GridView.builder(
                  itemCount: movies.length,

                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.7,
                  ),

                  itemBuilder: (context, index) {

                    final movie = movies[index];

                    return MovieCard(
                      imageUrl:
                      movie.largeCoverImage,

                      rate:
                      movie.rating.toString(),

                      movie: movie,

                      cardHeight: 279,
                      cardWidth: 189,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
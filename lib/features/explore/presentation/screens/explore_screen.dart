import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/widgets/empty_list_widget.dart';
import 'package:movies/features/explore/presentation/widgets/category_container.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/movie_card.dart';
import '../mangers/explore_cubit.dart';
import '../mangers/explore_states.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();

    final cubit = context.read<ExploreCubit>();

    cubit.fetchMoviesByGenre();

    _controller.addListener(() {
      final max = _controller.position.maxScrollExtent;
      final current = _controller.position.pixels;

      if (current >= max * 0.8) {
        cubit.loadMore();
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {

              if (state is ExploreLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is ExploreError) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppStyles.roboto20White400,
                  ),
                );
              }

              final cubit = context.read<ExploreCubit>();

              int selectedIndex = 0;
              List movies = [];

              if (state is ExploreSuccess) {
                selectedIndex = state.selectedIndex;
                movies = state.movies;
              }

              return Column(
                children: [

                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 48.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemCount: cubit.genres.length,

                      separatorBuilder: (_, __) =>
                          SizedBox(width: 8.w),

                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<ExploreCubit>()
                                .fetchMoviesByGenre(
                              index: index,
                            );
                          },

                          child: CategoryContainer(
                            isSelected:
                            selectedIndex == index,

                            category:
                            cubit.genres[index],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Expanded(
                    child: movies.isEmpty
                        ? const EmptyListWidget()
                        : GridView.builder(
                      controller: _controller,
                      itemCount: movies.length,

                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.7,
                      ),

                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return MovieCard(
                          movie: movie,
                          imageUrl:
                          movie.largeCoverImage,
                          rate: movie.rating.toString(),
                          cardHeight: 279,
                          cardWidth: 189,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

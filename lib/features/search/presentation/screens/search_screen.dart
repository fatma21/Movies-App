import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/widgets/movie_card.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../managers/search_cubit.dart';
import '../managers/search_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<SearchCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: "Search",
                prefixIcon: Transform.scale(
                  scale: 0.5,
                  child: Image.asset(AppImages.searchIcon),
                ),
                onChanged: (value) {
                  context.read<SearchCubit>().onSearchChanged(value);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor
                        ),
                      );
                    }

                    if (state is SearchEmpty) {
                      return const EmptyListWidget();
                    }

                    if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (state is SearchSuccess) {
                      return GridView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieCard(movie: movie,
                            imageUrl: movie.largeCoverImage,
                            rate: movie.rating.toString(),
                            cardHeight: 279,
                            cardWidth: 191,);
                        },
                      );
                    }
                    return const EmptyListWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
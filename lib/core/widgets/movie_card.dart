import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repo.dart';
import '../../features/movies_detials/presentation/managers/details_cubit.dart';
import '../../features/movies_detials/presentation/screens/movies_details_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../di/service_locator.dart';
import '../models/movies_model.dart';
import '../network/api_service.dart';

class MovieCard extends StatelessWidget {
  final String? imageUrl;
  final int cardHeight;
  final int cardWidth;
  final String? rate;
  final MovieModel movie;
  const MovieCard({super.key,this.cardHeight=220,this.cardWidth=146,this.imageUrl,this.rate="7.7",required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => DetailsCubit(
                sl<HomeRepo>(),
              )..fetchMovieDetails(movie.id),
              child: MoviesDetailsScreen(movie: movie),
            ),
          ),
        );
      },
      child: Stack(
        children:[
          Container(
            width: cardWidth.w,
            height: cardHeight.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(image: imageUrl==null?
              AssetImage("assets/images/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_9ef86295-4756-4c71-bb4e-20745c5fbc1a 5.png")
                  :NetworkImage(imageUrl!), fit: BoxFit.cover),
            ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xB5121312),
                  borderRadius: BorderRadius.circular(10.r)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 8.w
                ),
                child: Row(
                  spacing: 5.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(rate!,style: AppStyles.roboto16White400,),
                    Icon(Icons.star,color: AppColors.primaryColor,)
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class MovieCard extends StatelessWidget {
  final int cardHeight;
  final int cardWidth;
  const MovieCard({super.key,this.cardHeight=220,this.cardWidth=146});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          width: cardWidth.w,
          height: cardHeight.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(image: AssetImage("assets/images/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_9ef86295-4756-4c71-bb4e-20745c5fbc1a 5.png"), fit: BoxFit.cover),
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
                  Text("7.7",style: AppStyles.roboto16White400,),
                  Icon(Icons.star,color: AppColors.primaryColor,)
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}

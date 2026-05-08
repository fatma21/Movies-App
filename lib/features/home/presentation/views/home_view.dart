import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_styles.dart';
import 'package:movies/core/widgets/movie_card.dart';

import '../../../../core/constants/app_colors.dart';

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
  int currentSlide=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    child: Image.asset(
                      "assets/images/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_9ef86295-4756-4c71-bb4e-20745c5fbc1a 5.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(AppImages.availableNow),
                      SizedBox(
                        height: 351.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: 5,
                          onPageChanged: (index) {
                            setState(() {
                              currentSlide = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            double scale = currentSlide == index ? 1.0 : 0.8;
                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              tween: Tween<double>(begin: scale, end: scale),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: const MovieCard(cardHeight: 351,cardWidth: 234,),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 38.w
                        ),
                        child: Image.asset(AppImages.watchNow),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Action",style: AppStyles.roboto20White400,),
                        TextButton(
                            onPressed: (){},
                            child: Row(
                              children: [
                                Text("See More", style: AppStyles.roboto16Yellow400,),
                                Icon(Icons.arrow_forward,color: AppColors.primaryColor,)
                              ],
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 220.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return MovieCard();
                          },
                          separatorBuilder: (context,index){
                            return SizedBox(width: 16.w,);
                          },
                          itemCount: 10),
                    ),
                    SizedBox(height: 100.h,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

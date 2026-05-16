import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/widgets/empty_list_widget.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/explore/presentation/widgets/category_container.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w
            ),
            child: Column(
              spacing: 25.h,
              children: [
                SizedBox(
                  height: 48.h,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return InkWell(
                            onTap: (){
                              selectedIndex=index;
                              setState(() {


                              });
                            },
                            child: CategoryContainer(isSelected: index==selectedIndex,));
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(width: 8,);
                      },
                      itemCount: 5),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 20.w,
                        childAspectRatio: 0.7,

                      ),
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return EmptyListWidget();
                        //MovieCard(cardWidth: 189,cardHeight: 279,);
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

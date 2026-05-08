import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_routes.dart';
import 'package:movies/core/constants/app_styles.dart';
import 'package:movies/core/widgets/empty_list_widget.dart';
import 'package:movies/core/widgets/primary_elevated_button.dart';
import 'package:movies/features/profile/presentation/managers/profile_state.dart';
import '../managers/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrayColor,
      body: Column(
        spacing: 33.h,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h,right: 24.w,left: 24.w),
            child: Column(
              spacing: 23.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileCubit,ProfileState>(
                        builder: (context,state){
                          return Column(
                            spacing: 15.h,
                            children: [
                              Image.asset(state.selectedAvatar??AppImages.avatar1,width: 118.w,height: 118.h,),
                              Text(state.editedName??"User Name",style: AppStyles.roboto20White700,)
                            ],
                          );
                        }
                    ),
                    Column(
                      spacing: 20.h,
                      children: [
                        Text("12",style: AppStyles.roboto36White700,),
                        Text("Wish List",style: AppStyles.roboto24White700,),
                      ],
                    ),
                    Column(
                      spacing: 20.h,
                      children: [
                        Text("10",style: AppStyles.roboto36White700,),
                        Text("History",style: AppStyles.roboto24White700,),
                      ],
                    )
                  ],
                ),
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: PrimaryElevatedButton(
                          child: Text("Edit Profile",style: AppStyles.roboto20Dark400,),
                          onPressed: (){
                            Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                          }
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.loginScreen,
                                (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          spacing: 10.w,
                          children: [
                            Text(
                              "Exit",
                              style: AppStyles.roboto20White400,
                            ),
                            Image.asset(AppImages.exitIcon,width: 16.w,height: 18.h,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: AppColors.primaryColor,
                    indicatorWeight: 3,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: AppStyles.roboto20White400,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.list, size: 40.sp,color: AppColors.primaryColor,),
                        text: "Watch List",
                      ),
                      Tab(
                        icon: Icon(Icons.folder, size: 40.sp,color: AppColors.primaryColor,),
                        text: "History",
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.darkColor,
                      child: TabBarView(
                        children: [
                          EmptyListWidget(),
                          EmptyListWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/app_images.dart';
import 'package:movies/core/constants/app_routes.dart';
import 'package:movies/features/profile/presentation/widgets/image_card.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custome_textformfield.dart';
import '../../../../core/widgets/primary_elevated_button.dart';
import '../managers/profile_cubit.dart';
import '../managers/profile_state.dart';


class EditProfile extends StatelessWidget {
  EditProfile({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        },
            icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,)
        ),
        title: Text("Pick Avatar",style: AppStyles.roboto16Yellow400,),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {

          final cubit = context.read<ProfileCubit>();

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 35.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(
                  onTap: () => showAvatarPicker(context,cubit),
                  child: Center(
                    child: Image.asset(
                      state.selectedAvatar ?? AppImages.avatar1,
                      width: 150.w,
                      height: 150.h,
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                CustomTextFormField(
                  hintText: state.editedName??"Name",
                  onChanged: (value) {
                    cubit.updateDraft(name: value);
                  },
                  prefixIcon: Image.asset(
                    AppImages.passwordIcon,
                    width: 26.w,
                    height: 30.h,
                  ),
                ),

                SizedBox(height: 18.h),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  hintText: state.editedPhone??"Phone Number",
                  onChanged: (value) {
                    cubit.updateDraft(phone: value);
                  },
                  prefixIcon: Image.asset(
                    AppImages.phoneIcon,
                    width: 26.w,
                    height: 30.h,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
                  },
                  child: Text(
                    "Reset Password",
                    style: AppStyles.roboto20White400,
                  ),
                ),

                const Spacer(),

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
                    child: Text(
                      "Delete Account",
                      style: AppStyles.roboto20White400,
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                PrimaryElevatedButton(
                  onPressed: () {
                    cubit.updateProfileData(
                      FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                  child: state.isUpdating
                      ? const CircularProgressIndicator()
                      : Text(
                    "Update Data",
                    style: AppStyles.roboto20Dark400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showAvatarPicker(BuildContext context,ProfileCubit cubit) {
  const List<String> images=[AppImages.avatar1,AppImages.avatar2,AppImages.avatar3,AppImages.avatar4,AppImages.avatar5
    ,AppImages.avatar6,AppImages.avatar7,AppImages.avatar8,AppImages.avatar9];
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.darkColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
            crossAxisSpacing: 18.w,
            mainAxisSpacing: 18.h,),
          itemCount: 9,
          itemBuilder: (context,index){
            bool isSelected = index == 1;
            return InkWell(
              onTap: () {
                cubit.updateDraft(avatar: images[index]);
                Navigator.pop(context);
              },
              child: ImageCard(image:images[index],isSelected: isSelected),
            );
          }
      );
    },
  );
}

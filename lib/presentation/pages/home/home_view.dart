import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';

class HomeView extends StatelessWidget {

  HomeView({super.key});
  int currentIndex = 0;
  List<Widget>screens=[Text("Home"),Text("Search"),Text("Explore"),Text("Profile")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children:[
          screens[currentIndex],
          Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h), // Creates the "floating" effect
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E), // Dark gray background from your image
            borderRadius: BorderRadius.circular(16.r), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_filled, currentIndex == 0, 0),
              buildNavItem(Icons.search, currentIndex == 1, 1),
              buildNavItem(Icons.explore_outlined, currentIndex == 2, 2),
              buildNavItem(Icons.person_outline, currentIndex == 3, 3),
            ],
          ),
        ),
    ]
      ),
    );
  }
}
Widget buildNavItem(IconData icon, bool isSelected, int index) {
  return IconButton(
    onPressed: () {
      // Logic to change index via your Cubit
    },
    icon: Icon(
      icon,
      color: isSelected ? const Color(0xFFFFBB3B) : Colors.white,
      size: 28.sp,
    ),
  );
}

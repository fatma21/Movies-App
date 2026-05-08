import 'package:flutter/material.dart';

import '../constants/app_images.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset(AppImages.emptyImage));
  }
}

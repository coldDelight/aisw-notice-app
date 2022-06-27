import 'package:flutter/material.dart';
import 'package:hoseo_notice/themes/app_value.dart';

class Loading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const Loading({
    required this.isLoading,
    required this.child,
  })  ;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.mainColor,),
      );
    }
    return child;
  }
}

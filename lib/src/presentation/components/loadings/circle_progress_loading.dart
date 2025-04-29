import 'package:flutter/material.dart';

class CircleProgressLoading extends StatelessWidget {
  const CircleProgressLoading({super.key, this.size});

  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size?.width ?? 72.0,
        height: size?.height ?? 72.0,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

import 'package:base_flutter/src/presentation/resources/dimens.dart';
import 'package:base_flutter/src/presentation/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    required this.colors,
    required this.child,
  });

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      period: const Duration(milliseconds: 2000),
      gradient: LinearGradient(
        begin: const Alignment(1, 0.5),
        end: const Alignment(-1, -0.25),
        colors: colors,
      ),
      child: child,
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(DimenRes.padding_md)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionShimmer extends StatelessWidget {
  const TransactionShimmer({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
        children: List.generate(
      4,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey[100]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: height ?? mediaQuery.height / 8,
          margin: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 80,
              vertical: mediaQuery.height / 100),
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 80,
              vertical: mediaQuery.height / 80),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

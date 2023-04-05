import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:shimmer/shimmer.dart';

class HomeSkeletonLoading extends StatelessWidget {
  const HomeSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.spacing20,
          top: AppDimensions.spacing28,
          right: AppDimensions.spacing20,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white12,
          highlightColor: Colors.white30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderSkeleton(screenWidth),
              const Expanded(child: SizedBox.shrink()),
              _buildSkeleton(width: screenWidth / 6),
              const SizedBox(height: AppDimensions.spacing18),
              _buildSkeleton(width: screenWidth / 1.5),
              const SizedBox(height: AppDimensions.spacing10),
              _buildSkeleton(width: screenWidth / 3),
              const SizedBox(height: AppDimensions.spacing18),
              _buildSkeleton(width: screenWidth / 1.2),
              const SizedBox(height: AppDimensions.spacing10),
              _buildSkeleton(width: screenWidth / 1.5),
              const SizedBox(height: AppDimensions.spacing54),
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeaderSkeleton(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeleton(width: screenWidth / 2),
              const SizedBox(height: AppDimensions.spacing16),
              _buildSkeleton(width: screenWidth / 3),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimensions.spacing18),
          child: _buildSkeleton(
            width: AppDimensions.homeAvatarSize,
            height: AppDimensions.homeAvatarSize,
            borderRadius: AppDimensions.homeAvatarSize,
          ),
        ),
      ],
    );
  }

  Widget _buildSkeleton({
    required double width,
    double height = AppDimensions.homeSkeletonLoadingDefaultHeight,
    double borderRadius = AppDimensions.radius14,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
      ),
    );
  }
}

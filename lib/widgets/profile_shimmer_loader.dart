import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerLoader extends StatelessWidget {
  const ProfileShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Circular Avatar
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Container(height: 20, width: 150, color: Colors.white),
            const SizedBox(height: 8),

            // UserID badge
            Container(
              height: 28,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Personal Details Card
            _buildDetailCard([const SizedBox(height: 12)]),

            const SizedBox(height: 16),

            // Contact Details Card
            _buildDetailCard([const SizedBox(height: 12)]),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

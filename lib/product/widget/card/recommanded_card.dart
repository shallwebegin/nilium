import 'package:flutter/material.dart';
import 'package:nilium/product/constants/enums/image_size.dart';
import 'package:nilium/product/models/recommanded.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    super.key,
    required this.recommanded,
  });

  final Recommanded recommanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Image.network(
            recommanded.image ?? '',
            height: ImageSize.normal.value.toDouble(),
          ),
          Expanded(
            child: ListTile(
              title: Text(recommanded.title ?? ''),
              subtitle: Text(recommanded.description ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nilium/product/constants/color_constants.dart';
import 'package:nilium/product/constants/enums/widget_size.dart';
import 'package:nilium/product/models/news.dart';
import 'package:nilium/product/widget/text/subtitle_text.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({
    required this.newsItem,
  });

  final News? newsItem;

  @override
  Widget build(BuildContext context) {
    if (newsItem == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Image.network(newsItem!.backgroundImage ?? ''),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: ColorConstants.white,
                    size: WidgetSize.iconNormal.value.toDouble(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        value: newsItem!.category ?? '',
                        color: ColorConstants.grayLighter,
                      ),
                      Text(
                        newsItem!.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: ColorConstants.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

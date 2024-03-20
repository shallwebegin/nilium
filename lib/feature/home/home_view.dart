// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nilium/feature/home/home_provider.dart';
import 'package:nilium/feature/home/sub_view/home_search_delegate.dart';
import 'package:nilium/feature/home_create/home_create_view.dart';
import 'package:nilium/product/constants/color_constants.dart';
import 'package:nilium/product/constants/string_constants.dart';
import 'package:nilium/product/models/tag.dart';
import 'package:nilium/product/widget/card/home_news_card.dart';
import 'package:nilium/product/widget/card/recommanded_card.dart';
import 'package:nilium/product/widget/text/subtitle_text.dart';
import 'package:nilium/product/widget/text/title_text.dart';
part 'sub_view/home_chips.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(_homeProvider.notifier).fetchAndLoad());
    ref.read(_homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _controller.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final response =
              await Navigator.of(context).push<bool?>(MaterialPageRoute(
            builder: (context) => const HomeCreateView(),
          ));
          if (response ?? false) {
            await ref.read(_homeProvider.notifier).fetchAndLoad();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const _Header(),
                _CustomField(_controller),
                const _TagListView(),
                const _BrowseHorizontalListView(),
                const _RecommendedHeader(),
                const _RecommendListView(),
              ],
            ),
            if (ref.watch(_homeProvider).isLoading ?? false)
              const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}

class _CustomField extends ConsumerWidget {
  const _CustomField(this.controller);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
          context: context,
          delegate:
              HomeSearchDelegate(ref.read(_homeProvider.notifier).fullTagList),
        );
        ref.read(_homeProvider.notifier).updateSelectedTag(response);
      },
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.mic_outlined),
        prefixIcon: Icon(Icons.search_off_outlined),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: ColorConstants.grayLighter,
        hintText: StringConstants.homeSearchHint,
      ),
    );
  }
}

class _TagListView extends ConsumerWidget {
  const _TagListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newItems = ref.watch(_homeProvider).tags ?? [];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: newItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tagItem = newItems[index];
          if (tagItem.active ?? false) {
            return _ActiveChip(tagItem);
          }
          return _PassiveChip(tagItem);
        },
      ),
    );
  }
}

class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).news ?? [];
    return SizedBox(
      height: 256,
      child: ListView.builder(
        itemCount: newsItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return HomeNewsCard(newsItem: newsItems[index]);
        },
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleText(value: StringConstants.homeTitle),
          TextButton(
            onPressed: () {},
            child: const Text(StringConstants.homeSeeAll),
          ),
        ],
      ),
    );
  }
}

class _RecommendListView extends ConsumerWidget {
  const _RecommendListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(_homeProvider).recommanded ?? [];
    return ListView.builder(
      itemCount: values.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return RecommendedCard(recommanded: values[index]);
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          value: StringConstants.homeBrowse,
        ),
        SubtitleText(value: StringConstants.welcomeNiliumApp),
      ],
    );
  }
}

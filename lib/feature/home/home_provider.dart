// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nilium/product/models/news.dart';
import 'package:nilium/product/models/recommanded.dart';
import 'package:nilium/product/models/tag.dart';
import 'package:nilium/product/utility/firebase/firebase_collections.dart';
import 'package:nilium/product/utility/firebase/firebase_utility.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Tag> _fullTagList = [];
  List<Tag> get fullTagList => _fullTagList;

  Future<void> fetchNews() async {
    final items =
        await fetchList<News, News>(const News(), FirebaseCollections.news);
    state = state.copyWith(news: items);
  }

  Future<void> fetchTags() async {
    final items =
        await fetchList<Tag, Tag>(const Tag(), FirebaseCollections.tag);
    state = state.copyWith(tags: items);
    _fullTagList = items ?? [];
  }

  Future<void> fetchRecommanded() async {
    final items = await fetchList<Recommanded, Recommanded>(
        const Recommanded(), FirebaseCollections.recommanded);
    state = state.copyWith(recommanded: items);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);

    await Future.wait([fetchNews(), fetchTags(), fetchRecommanded()]);
    state = state.copyWith(isLoading: false);
  }

  void updateSelectedTag(Tag? tag) {
    if (tag == null) return;
    state = state.copyWith(selectedTag: tag);
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.news,
    this.isLoading,
    this.tags,
    this.recommanded,
    this.selectedTag,
  });

  final List<News>? news;
  final bool? isLoading;
  final List<Tag>? tags;
  final List<Recommanded>? recommanded;
  final Tag? selectedTag;

  @override
  List<Object?> get props => [news, isLoading, tags, recommanded, selectedTag];

  HomeState copyWith({
    List<News>? news,
    bool? isLoading,
    List<Tag>? tags,
    List<Recommanded>? recommanded,
    Tag? selectedTag,
  }) {
    return HomeState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      tags: tags ?? this.tags,
      recommanded: recommanded ?? this.recommanded,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}

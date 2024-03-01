import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CollectionReference news = FirebaseFirestore.instance.collection('news');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: news.get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const LinearProgressIndicator();
            case ConnectionState.done:
              break;
          }
        },
      ),
    );
  }
}

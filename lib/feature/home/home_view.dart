// ignore_for_file: lines_longer_than_80_chars, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nilium/product/models/news.dart';
import 'package:nilium/product/utility/exception/custom_exception.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 1 future builder
  // 2 datayi init oldugu anda cekip setstate le göstermek

  @override
  Widget build(BuildContext context) {
    final CollectionReference news =
        FirebaseFirestore.instance.collection('news');
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) throw FirebaseCustomException('$value not null');
        return value.toJson();
      },
    ).get();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const LinearProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();

                return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            values[index].backgroundImage ?? '',
                          ),
                          Text(
                            values[index].title ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
          }
        },
      ),
    );
  }
}

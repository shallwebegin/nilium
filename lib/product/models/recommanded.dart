// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:nilium/product/utility/base/base_firebase_model.dart';

@immutable
class Recommanded with EquatableMixin, IdModel, BaseFirebaseModel<Recommanded> {
  const Recommanded({
    this.image,
    this.description,
    this.title,
    this.id,
  });
  final String? image;
  final String? description;
  final String? title;
  @override
  final String? id;

  @override
  List<Object?> get props => [image, description, title, id];

  Recommanded copyWith({
    String? image,
    String? description,
    String? title,
    String? id,
  }) {
    return Recommanded(
      image: image ?? this.image,
      description: description ?? this.description,
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'description': description,
      'title': title,
    };
  }

  @override
  Recommanded fromJson(Map<String, dynamic> json) {
    return Recommanded(
      image: json['image'] as String?,
      description: json['description'] as String?,
      title: json['title'] as String?,
    );
  }
}

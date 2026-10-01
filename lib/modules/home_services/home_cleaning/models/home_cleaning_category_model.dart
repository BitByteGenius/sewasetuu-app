import 'package:flutter/material.dart';

/// Data model representing a sub-category in the Home Cleaning modal grid.
class HomeCleaningCategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final IconData fallbackIcon;
  final String? description;

  const HomeCleaningCategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.fallbackIcon,
    this.description,
  });

  factory HomeCleaningCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCleaningCategoryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      fallbackIcon: Icons.cleaning_services_rounded,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
        'description': description,
      };
}

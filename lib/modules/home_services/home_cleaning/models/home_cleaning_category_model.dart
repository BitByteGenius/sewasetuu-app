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
}

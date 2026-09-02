/// Standard pagination metadata model for list endpoints
class PaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;

  const PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalItems: json['total_items'] as int? ?? 0,
      hasNextPage: json['has_next_page'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'total_pages': totalPages,
        'total_items': totalItems,
        'has_next_page': hasNextPage,
      };
}

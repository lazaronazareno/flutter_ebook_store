import 'package:equatable/equatable.dart';

class ReadingBookModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final String cover;
  final bool isTrending;
  final int quantity;
  final bool isReading;
  final int currentPage;
  final int totalPages;
  final int stars;
  final String updatedAt;

  const ReadingBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.isTrending,
    this.quantity = 1,
    this.isReading = false,
    this.currentPage = 0,
    this.totalPages = 0,
    this.stars = 0,
    this.updatedAt = "",
  });

  ReadingBookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? cover,
    bool? isTrending,
    int? quantity,
    bool? isReading,
    int? currentPage,
    int? totalPages,
    int? stars,
    String? updatedAt,
  }) {
    return ReadingBookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      cover: cover ?? this.cover,
      isTrending: isTrending ?? this.isTrending,
      quantity: quantity ?? this.quantity,
      isReading: isReading ?? this.isReading,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      stars: stars ?? this.stars,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        cover,
        isTrending,
        quantity,
        isReading,
        currentPage,
        totalPages,
        stars,
        updatedAt,
      ];
}

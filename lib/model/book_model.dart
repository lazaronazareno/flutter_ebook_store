import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final String cover;
  final String description;
  final double price;
  final bool isTrending;
  final bool isFavorite;
  final bool isPurchased;
  final int quantity;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
    required this.isTrending,
    this.isFavorite = false,
    this.isPurchased = false,
    this.quantity = 1,
  });

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? cover,
    String? description,
    double? price,
    bool? isTrending,
    bool? isFavorite,
    bool? isPurchased,
    int? quantity,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      price: price ?? this.price,
      isTrending: isTrending ?? this.isTrending,
      isFavorite: isFavorite ?? this.isFavorite,
      isPurchased: isPurchased ?? this.isPurchased,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        cover,
        description,
        price,
        isTrending,
        isFavorite,
        isPurchased,
      ];
}

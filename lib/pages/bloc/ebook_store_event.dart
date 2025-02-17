part of 'ebook_store_bloc.dart';

sealed class EbookStoreEvent extends Equatable {
  const EbookStoreEvent();

  @override
  List<Object> get props => [];
}

//obtener todos los libros
class FetchBooksEvent extends EbookStoreEvent {}

class FetchTrendingBooksEvent extends EbookStoreEvent {}

//reading
class FetchReadingBooksEvent extends EbookStoreEvent {}

class AddToReadingEvent extends EbookStoreEvent {
  final String id;

  const AddToReadingEvent({required this.id});
}

class FetchBookByIdEvent extends EbookStoreEvent {
  final String id;

  const FetchBookByIdEvent({required this.id});
}

//dejarlo para el final
class SearchBooksEvent extends EbookStoreEvent {
  final String query;

  const SearchBooksEvent({required this.query});
}

//favoritos
class FetchBookmarksEvent extends EbookStoreEvent {}

class AddToBookmarksEvent extends EbookStoreEvent {
  final String id;

  const AddToBookmarksEvent({required this.id});
}

class RemoveFromBookmarksEvent extends EbookStoreEvent {
  final String id;

  const RemoveFromBookmarksEvent({required this.id});
}

//carrito
class FetchCartEvent extends EbookStoreEvent {}

class AddToCartEvent extends EbookStoreEvent {
  final String id;
  final int quantity;

  const AddToCartEvent({required this.id, this.quantity = 1});
}

class RemoveFromCartEvent extends EbookStoreEvent {
  final String id;

  const RemoveFromCartEvent({required this.id});
}

class UpdateCartEvent extends EbookStoreEvent {
  final BookModel book;
  final int newQuantity;

  const UpdateCartEvent({required this.book, required this.newQuantity});
}

class CheckoutCartEvent extends EbookStoreEvent {}

//admin
class AddBookEvent extends EbookStoreEvent {
  final BookModel book;

  const AddBookEvent({required this.book});
}

class UpdateBookEvent extends EbookStoreEvent {
  final BookModel book;

  const UpdateBookEvent({required this.book});
}

class DeleteBookEvent extends EbookStoreEvent {
  final String id;

  const DeleteBookEvent({required this.id});
}

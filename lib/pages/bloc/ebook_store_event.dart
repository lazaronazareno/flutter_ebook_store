part of 'ebook_store_bloc.dart';

sealed class EbookStoreEvent extends Equatable {
  const EbookStoreEvent();

  @override
  List<Object> get props => [];
}

//obtener todos los libros
class FetchBooksEvent extends EbookStoreEvent {}

class FetchTrendingBooksEvent extends EbookStoreEvent {}

class FetchReadingBooksEvent extends EbookStoreEvent {}

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
class AddToCartEvent extends EbookStoreEvent {
  final String id;

  const AddToCartEvent({required this.id});
}

class RemoveFromCartEvent extends EbookStoreEvent {
  final String id;

  const RemoveFromCartEvent({required this.id});
}

class UpdateCartEvent extends EbookStoreEvent {
  final String id;

  const UpdateCartEvent({required this.id});
}

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

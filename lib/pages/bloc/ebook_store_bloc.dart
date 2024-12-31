import 'package:dio/dio.dart';
import 'package:ebook_store/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ebook_store_event.dart';
part 'ebook_store_state.dart';

const bookUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_store';
const readingUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_store/reading';
const bookmarkUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_store/bookmark';
const cartUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_store/cart';

class EbookStoreBloc extends Bloc<EbookStoreEvent, EbookStoreState> {
  var uuid = const Uuid();
  var dio = Dio();

  EbookStoreBloc() : super(EbookStoreState.initial()) {
    on<FetchBooksEvent>(_onFetchBooks);
    on<FetchTrendingBooksEvent>(_onFetchTrendingBooks);
    on<FetchReadingBooksEvent>(_onFetchReadingBooks);
    on<FetchBookByIdEvent>(_onFetchBookById);
    on<SearchBooksEvent>(_onSearchBooks);
    on<AddToBookmarksEvent>(_onAddToBookmarks);
    on<RemoveFromBookmarksEvent>(_onRemoveFromBookmarks);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartEvent>(_onUpdateCart);
    on<AddBookEvent>(_onAddBook);
    on<UpdateBookEvent>(_onUpdateBook);
    on<DeleteBookEvent>(_onDeleteBook);
  }

  void _onFetchBooks(
    FetchBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(booksScreenStatus: BooksScreenStatus.loading));

    final response = await dio.get("$bookUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state
          .copyWith(booksScreenStatus: BooksScreenStatus.success, books: []));
      return;
    }

    final booksData = data.entries.map((item) {
      final book = item.value;
      return BookModel(
        id: book['id'],
        title: book['title'],
        author: book['author'],
        cover: book['cover'],
        description: book['description'],
        price: book['price'],
        isTrending: book['isTrending'] ?? false,
        isFavorite: book['isFavorite'] ?? false,
        isPurchased: book['isPurchased'] ?? false,
      );
    }).toList();

    emit(state.copyWith(
      booksScreenStatus: BooksScreenStatus.success,
      books: booksData,
    ));
  }

  void _onFetchTrendingBooks(
    FetchTrendingBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onFetchReadingBooks(
    FetchReadingBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onFetchBookById(
    FetchBookByIdEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onSearchBooks(
    SearchBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onAddToBookmarks(
    AddToBookmarksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onRemoveFromBookmarks(
    RemoveFromBookmarksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onAddToCart(
    AddToCartEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onUpdateCart(
    UpdateCartEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onAddBook(
    AddBookEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onUpdateBook(
    UpdateBookEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onDeleteBook(
    DeleteBookEvent event,
    Emitter<EbookStoreState> emit,
  ) {}
}

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/model/reading_book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ebook_store_event.dart';
part 'ebook_store_state.dart';

const bookUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_store';
const readingUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_reading';
const bookmarkUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_bookmark';
const cartUrl =
    'https://lazaro-portfolio-default-rtdb.firebaseio.com/ebook_cart';

class EbookStoreBloc extends Bloc<EbookStoreEvent, EbookStoreState> {
  var uuid = const Uuid();
  var dio = Dio();

  EbookStoreBloc() : super(EbookStoreState.initial()) {
    on<FetchBooksEvent>(_onFetchBooks);
    on<FetchTrendingBooksEvent>(_onFetchTrendingBooks);
    on<FetchReadingBooksEvent>(_onFetchReadingBooks);
    on<FetchBookByIdEvent>(_onFetchBookById);
    on<SearchBooksEvent>(_onSearchBooks);
    on<FetchBookmarksEvent>(_onFetchBookmarks);
    on<AddToBookmarksEvent>(_onAddToBookmarks);
    on<RemoveFromBookmarksEvent>(_onRemoveFromBookmarks);
    on<FetchCartEvent>(_onFetchCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartEvent>(_onUpdateCart);
    on<CheckoutCartEvent>(_onCheckoutCart);
    on<AddToReadingEvent>(_onAddToReading);
    on<AddBookEvent>(_onAddBook);
    on<UpdateBookEvent>(_onUpdateBook);
    on<DeleteBookEvent>(_onDeleteBook);
  }

  void _onFetchBooks(
    FetchBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(
      homeScreenStatus: HomeScreenStatus.loading,
    ));

    final response = await dio.get("$bookUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state
          .copyWith(homeScreenStatus: HomeScreenStatus.success, books: []));
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
        price: double.parse(book['price'].toString()),
        isTrending: book['isTrending'] ?? false,
      );
    }).toList();

    final trendingBooks = booksData.where((book) => book.isTrending).toList();

    emit(state.copyWith(
      books: booksData,
      trendingBooks: trendingBooks,
      homeScreenStatus: HomeScreenStatus.success,
    ));
  }

  void _onFetchTrendingBooks(
    FetchTrendingBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {}

  void _onFetchReadingBooks(
    FetchReadingBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(
      readingScreenStatus: ReadingScreenStatus.loading,
    ));

    final response = await dio.get("$readingUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(
          readingScreenStatus: ReadingScreenStatus.success, readingBooks: []));
      return;
    }

    final readingBooksData = data.entries.map((item) {
      final book = item.value;
      return ReadingBookModel(
        id: book['id'],
        title: book['title'],
        author: book['author'],
        cover: book['cover'],
        isTrending: book['isTrending'] ?? false,
        quantity: book['quantity'],
        isReading: book['isReading'],
        currentPage: book['currentPage'],
        totalPages: book['totalPages'],
        stars: book['stars'],
        updatedAt: book['updatedAt'] ?? "",
      );
    }).toList();

    emit(state.copyWith(
      readingBooks: readingBooksData,
      readingScreenStatus: ReadingScreenStatus.success,
    ));
  }

  void _onFetchBookById(
    FetchBookByIdEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onSearchBooks(
    SearchBooksEvent event,
    Emitter<EbookStoreState> emit,
  ) {}

  void _onFetchBookmarks(
    FetchBookmarksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(bookmarksScreenStatus: BookMarkScreenStatus.loading));

    final response = await dio.get("$bookmarkUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(
          bookmarksScreenStatus: BookMarkScreenStatus.success, bookmarks: []));
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
        price: double.parse(book['price'].toString()),
        isTrending: book['isTrending'] ?? false,
      );
    }).toList();

    emit(state.copyWith(
      bookmarksScreenStatus: BookMarkScreenStatus.success,
      bookmarks: booksData,
    ));
  }

  void _onAddToBookmarks(
    AddToBookmarksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    final book = state.books.firstWhere((book) => book.id == event.id);

    await dio.put("$bookmarkUrl/${book.id}.json", data: {
      "id": book.id,
      "title": book.title,
      "author": book.author,
      "cover": book.cover,
      "description": book.description,
      "price": book.price,
      "isTrending": book.isTrending,
    });

    final newBookmarks = [...state.bookmarks, book];

    emit(state.copyWith(bookmarks: newBookmarks));
  }

  void _onRemoveFromBookmarks(
    RemoveFromBookmarksEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    await dio.delete("$bookmarkUrl/${event.id}.json");

    final newBookmarks =
        state.bookmarks.where((book) => book.id != event.id).toList();

    emit(state.copyWith(bookmarks: newBookmarks));
  }

  void _onFetchCart(
    FetchCartEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(cartScreenStatus: CartScreenStatus.loading));

    final response = await dio.get("$cartUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(
          state.copyWith(cartScreenStatus: CartScreenStatus.success, cart: []));
      return;
    }

    final cartData = data.entries.map((item) {
      final book = item.value;
      return BookModel(
        id: book['id'],
        title: book['title'],
        author: book['author'],
        description: book['description'],
        price: double.parse(book['price'].toString()),
        cover: book['cover'],
        isTrending: book['isTrending'] ?? false,
        quantity: book['quantity'],
      );
    }).toList();

    emit(state.copyWith(
      cartScreenStatus: CartScreenStatus.success,
      cart: cartData,
    ));
  }

  void _onAddToCart(
    AddToCartEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    final book = state.books.firstWhere((book) => book.id == event.id);

    final existItemIndex = state.cart.indexWhere((p) => p.id == book.id);

    if (existItemIndex >= 0) {
      final itemProd = state.cart[existItemIndex];
      final newQuantity = itemProd.quantity + event.quantity;
      if (newQuantity > 5) {
        return;
      }

      await dio.patch(
        "$cartUrl/${book.id}.json",
        data: {"quantity": newQuantity},
      );

      final updateCart = [...state.cart];
      updateCart[existItemIndex] = itemProd.copyWith(quantity: newQuantity);
      emit(state.copyWith(cart: updateCart));
      return;
    } else {
      await dio.put("$cartUrl/${book.id}.json", data: {
        "id": book.id,
        "title": book.title,
        "author": book.author,
        "cover": book.cover,
        "description": book.description,
        "price": book.price,
        "isTrending": book.isTrending,
        "quantity": event.quantity,
      });

      final newCart = [...state.cart, book.copyWith(quantity: event.quantity)];
      emit(state.copyWith(cart: newCart));
    }
  }

  void _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    final book = state.cart.firstWhere((book) => book.id == event.id);

    await dio.delete("$cartUrl/${book.id}.json");

    final updatedCart =
        state.cart.where((book) => book.id != event.id).toList();

    emit(state.copyWith(cart: updatedCart));
  }

  void _onUpdateCart(
    UpdateCartEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(cartScreenStatus: CartScreenStatus.loading));
    final book = event.book;

    final existItemIndex = state.cart.indexWhere((p) => p.id == book.id);

    if (existItemIndex < 0 || event.newQuantity > 5) {
      return;
    }

    await dio.patch(
      "$cartUrl/${book.id}.json",
      data: {"quantity": event.newQuantity},
    );

    final updatedCart = [...state.cart];
    updatedCart[existItemIndex] = book.copyWith(quantity: event.newQuantity);

    emit(state.copyWith(
        cart: updatedCart, cartScreenStatus: CartScreenStatus.success));
  }

  void _onCheckoutCart(
    CheckoutCartEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(cartScreenStatus: CartScreenStatus.loading));

    final random = Random();

    final data = state.cart.map((book) {
      final int randomPageNumber = random.nextInt(800) + 80;
      final int randomStars = random.nextInt(5) + 1;
      return {
        "id": book.id,
        "title": book.title,
        "author": book.author,
        "cover": book.cover,
        "isTrending": book.isTrending,
        "quantity": book.quantity,
        "isReading": false,
        "currentPage": 0,
        "totalPages": randomPageNumber,
        "stars": randomStars,
        "updatedAt": "",
      };
    }).toList();

    final readingBooksList = data.map((item) {
      return ReadingBookModel(
        id: item["id"].toString(),
        title: item["title"].toString(),
        author: item["author"].toString(),
        cover: item["cover"].toString(),
        isTrending: bool.parse(item["isTrending"].toString()),
        quantity: int.parse(item["quantity"].toString()),
        isReading: bool.parse(item["isReading"].toString()),
        currentPage: int.parse(item["currentPage"].toString()),
        totalPages: int.parse(item["totalPages"].toString()),
        stars: item["stars"] as int,
        updatedAt: item["updatedAt"].toString(),
      );
    }).toList();

    for (var book in data) {
      await dio.put("$readingUrl/${book["id"]}.json", data: book);
    }

    for (var book in data) {
      await dio.delete("$cartUrl/${book["id"]}.json");
    }

    emit(state.copyWith(
        readingBooks: readingBooksList,
        cart: [],
        cartScreenStatus: CartScreenStatus.success));
  }

  void _onAddBook(
    AddBookEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(homeScreenStatus: HomeScreenStatus.loading));

    final String newBookId = uuid.v1();
    final BookModel newBook = event.book;

    final data = {
      "id": newBookId,
      "title": event.book.title,
      "author": event.book.author,
      "cover": event.book.cover,
      "description": event.book.description,
      "price": event.book.price,
      "isTrending": event.book.isTrending,
    };

    List<BookModel> updatedBooks = [];

    await dio.put("$bookUrl/$newBookId.json", data: data);
    updatedBooks = [...state.books, newBook];

    final updatedTrendingBooks = updatedBooks.where((book) {
      return book.isTrending;
    }).toList();

    emit(state.copyWith(
        books: updatedBooks,
        trendingBooks: updatedTrendingBooks,
        homeScreenStatus: HomeScreenStatus.success));
  }

  void _onUpdateBook(
    UpdateBookEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(homeScreenStatus: HomeScreenStatus.loading));

    final data = {
      "id": event.book.id,
      "title": event.book.title,
      "author": event.book.author,
      "cover": event.book.cover,
      "description": event.book.description,
      "price": event.book.price,
      "isTrending": event.book.isTrending,
    };

    await dio.patch("$bookUrl/${event.book.id}.json", data: data);

    final updatedBooks = state.books.map((item) {
      if (item.id == event.book.id) {
        return event.book;
      }
      return item;
    }).toList();

    final updatedTrendingBooks = updatedBooks.where((book) {
      return book.isTrending;
    }).toList();

    emit(state.copyWith(
        books: updatedBooks,
        trendingBooks: updatedTrendingBooks,
        homeScreenStatus: HomeScreenStatus.success));
  }

  void _onDeleteBook(
    DeleteBookEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(homeScreenStatus: HomeScreenStatus.loading));
    await dio.delete("$bookUrl/${event.id}.json");

    final updatedBooks =
        state.books.where((book) => book.id != event.id).toList();

    final updatedTrendingBooks = updatedBooks.where((book) {
      return book.isTrending;
    }).toList();

    emit(state.copyWith(
        books: updatedBooks,
        trendingBooks: updatedTrendingBooks,
        homeScreenStatus: HomeScreenStatus.success));
  }

  void _onAddToReading(
    AddToReadingEvent event,
    Emitter<EbookStoreState> emit,
  ) async {
    emit(state.copyWith(readingScreenStatus: ReadingScreenStatus.loading));
    final book = state.readingBooks.firstWhere((book) => book.id == event.id);

    final random = Random();
    final int randomCurrentPageNumber = random.nextInt(book.totalPages) + 0;

    final data = {
      "id": book.id,
      "title": book.title,
      "author": book.author,
      "cover": book.cover,
      "isTrending": book.isTrending,
      "quantity": book.quantity,
      "isReading": true,
      "currentPage": randomCurrentPageNumber,
      "totalPages": book.totalPages,
      "stars": book.stars,
      "updatedAt": DateTime.now().toIso8601String(),
    };

    await dio.put("$readingUrl/${book.id}.json", data: data);

    final newReadingBooks = state.readingBooks.map((item) {
      if (item.id == book.id) {
        return book.copyWith(
            isReading: true, updatedAt: data["updatedAt"].toString());
      }
      return item;
    }).toList();

    emit(state.copyWith(
        readingBooks: newReadingBooks,
        readingScreenStatus: ReadingScreenStatus.success));
  }
}

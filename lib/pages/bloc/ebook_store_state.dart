part of 'ebook_store_bloc.dart';

enum HomeScreenStatus { none, loading, success, error }

enum AdminScreenStatus { none, loading, success, error }

enum BookMarkScreenStatus { none, loading, success, error }

enum ReadingScreenStatus { none, loading, success, error }

class EbookStoreState extends Equatable {
  final List<BookModel> books;
  final List<BookModel> trendingBooks;
  final List<BookModel> readingBooks;
  final List<BookModel> bookmarks;
  final List<BookModel> cart;
  final List<BookModel> catalogBooks;
  final List<BookModel> searchBooks;
  final HomeScreenStatus homeScreenStatus;
  final AdminScreenStatus adminScreenStatus;
  final BookMarkScreenStatus bookmarksScreenStatus;
  final ReadingScreenStatus readingScreenStatus;

  const EbookStoreState({
    required this.books,
    required this.trendingBooks,
    required this.readingBooks,
    required this.bookmarks,
    required this.cart,
    required this.catalogBooks,
    required this.searchBooks,
    required this.homeScreenStatus,
    required this.adminScreenStatus,
    required this.bookmarksScreenStatus,
    required this.readingScreenStatus,
  });

  factory EbookStoreState.initial() {
    return const EbookStoreState(
      books: [],
      trendingBooks: [],
      readingBooks: [],
      bookmarks: [],
      cart: [],
      catalogBooks: [],
      searchBooks: [],
      homeScreenStatus: HomeScreenStatus.none,
      adminScreenStatus: AdminScreenStatus.none,
      bookmarksScreenStatus: BookMarkScreenStatus.none,
      readingScreenStatus: ReadingScreenStatus.none,
    );
  }

  EbookStoreState copyWith({
    List<BookModel>? books,
    List<BookModel>? trendingBooks,
    List<BookModel>? readingBooks,
    List<BookModel>? bookmarks,
    List<BookModel>? cart,
    List<BookModel>? catalogBooks,
    List<BookModel>? searchBooks,
    HomeScreenStatus? homeScreenStatus,
    AdminScreenStatus? adminScreenStatus,
    BookMarkScreenStatus? bookmarksScreenStatus,
    ReadingScreenStatus? readingScreenStatus,
  }) {
    return EbookStoreState(
      books: books ?? this.books,
      trendingBooks: trendingBooks ?? this.trendingBooks,
      readingBooks: readingBooks ?? this.readingBooks,
      bookmarks: bookmarks ?? this.bookmarks,
      cart: cart ?? this.cart,
      catalogBooks: catalogBooks ?? this.catalogBooks,
      searchBooks: searchBooks ?? this.searchBooks,
      homeScreenStatus: homeScreenStatus ?? this.homeScreenStatus,
      adminScreenStatus: adminScreenStatus ?? this.adminScreenStatus,
      bookmarksScreenStatus:
          bookmarksScreenStatus ?? this.bookmarksScreenStatus,
      readingScreenStatus: readingScreenStatus ?? this.readingScreenStatus,
    );
  }

  @override
  List<Object> get props => [
        books,
        trendingBooks,
        readingBooks,
        bookmarks,
        cart,
        catalogBooks,
        searchBooks,
        homeScreenStatus,
        adminScreenStatus,
        bookmarksScreenStatus,
        readingScreenStatus,
      ];
}

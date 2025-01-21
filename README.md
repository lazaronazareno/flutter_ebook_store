# ebook_store

A Flutter project for managing an ebook store. This project includes functionalities for browsing, adding, updating, and deleting books, as well as managing a shopping cart and reading list.

This was builded as the final project for my course of Flutter with **{desafio} latam\_** and **Globant**

There is a APK preview of the app in [releases](https://github.com/lazaronazareno/flutter_ebook_store/releases/tag/v1.0.0).

## Features

- **Browse Books**: View a list of available books.
- **Trending Books**: View a list of trending books.
- **Book Details**: View detailed information about a book.
- **Add to Cart**: Add books to the shopping cart.
- **Update Cart**: Update the quantity of books in the cart.
- **Checkout**: Checkout books from the cart and add them to the reading list.
- **Reading List**: View and manage the list of books being read.
- **Admin Page**: Add, update, and delete books from the store.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK: Included with Flutter

### Installation

1. Clone the repository:

```
git clone https://github.com/lazaronazareno/flutter_ebook_store.git
```

2. Install dependencies:

```
flutter pub get
```

3. Run the app:

```
flutter run
```

## Project Structure

- lib/pages: Contains the main pages of the application (Home, Admin, Cart, etc.).
- lib/widgets: Contains reusable widgets (SearchBar, TrendingBooks, etc.).
- lib/model: Contains data models (BookModel, ReadingBookModel, etc.).
- lib/bloc: Contains BLoC (Business Logic Component) files for state management.

## Usage

#### Home Page

- Displays a list of trending books.
- Allows navigation to the Admin Page and Cart Page.

#### Admin Page

- Add new books to the store.
- Update existing books.
- Delete books from the store.

#### Cart Page

- View books added to the cart.
- Update the quantity of books in the cart.
- Checkout books to add them to the reading list.

#### Reading List

- View the list of books being read.
- View details of the latest updated book.

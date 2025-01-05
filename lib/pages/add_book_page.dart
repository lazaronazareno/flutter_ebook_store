import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBookPage extends StatefulWidget {
  final BookModel? bookModel;
  final bool isEditMode;

  const AddBookPage({super.key, this.bookModel, this.isEditMode = false});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _bookTitleController = TextEditingController();
  final TextEditingController _bookAuthorController = TextEditingController();
  final TextEditingController _bookPriceController = TextEditingController();
  final TextEditingController _bookCoverController = TextEditingController();
  final TextEditingController _bookIsTrendingController =
      TextEditingController();
  final TextEditingController _bookDescriptionController =
      TextEditingController();
  bool isTrending = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      setState(() {
        _bookTitleController.text = widget.bookModel!.title;
        _bookAuthorController.text = widget.bookModel!.author;
        _bookPriceController.text = widget.bookModel!.price.toString();
        _bookCoverController.text = widget.bookModel!.cover;
        _bookDescriptionController.text = widget.bookModel!.description;
        isTrending = widget.bookModel!.isTrending;
      });
    }
  }

  void _addProduct(BuildContext context) {
    if (widget.isEditMode) {
      context.read<EbookStoreBloc>().add(
            UpdateBookEvent(
              book: BookModel(
                id: widget.bookModel!.id,
                title: _bookTitleController.text,
                author: _bookAuthorController.text,
                cover: _bookCoverController.text,
                description: _bookDescriptionController.text,
                price: double.parse(_bookPriceController.text),
                isTrending: isTrending,
              ),
            ),
          );
    } else {
      context.read<EbookStoreBloc>().add(
            AddBookEvent(
              book: BookModel(
                id: "",
                title: _bookTitleController.text,
                author: _bookAuthorController.text,
                cover: _bookCoverController.text,
                description: _bookDescriptionController.text,
                price: double.parse(_bookPriceController.text),
                isTrending: isTrending,
              ),
            ),
          );
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _bookTitleController.dispose();
    _bookAuthorController.dispose();
    _bookPriceController.dispose();
    _bookCoverController.dispose();
    _bookIsTrendingController.dispose();
    _bookDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.isEditMode ? "Edit Book" : "Add Book"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextInput("Title", _bookTitleController, TextInputType.text),
            buildTextInput("Author", _bookAuthorController, TextInputType.text),
            buildTextInput("Price", _bookPriceController, TextInputType.number),
            buildTextInput("Cover", _bookCoverController, TextInputType.text),
            buildTextInput(
                "Description", _bookDescriptionController, TextInputType.text),
            SwitchListTile(
                title: const Text("Is Trending"),
                value: isTrending,
                activeColor: AppColors.green,
                onChanged: (value) {
                  setState(() {
                    isTrending = value;
                  });
                }),
            const Expanded(child: SizedBox(height: 12)),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.orange),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 48),
                ),
              ),
              onPressed: () => _addProduct(context),
              child: Text(widget.isEditMode ? "Edit Book" : "Add Book",
                  style: const TextStyle(color: AppColors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextInput(String labelText, TextEditingController controller,
      TextInputType keyboardType) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter $labelText";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}

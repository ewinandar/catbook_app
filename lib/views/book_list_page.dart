import 'package:catbook_app/controllers/book_controller.dart';
import 'package:catbook_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPage();
}

class _BookListPage extends State<BookListPage> {
  BookController? bookController;
  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Book Catalogue'))),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: bookController!.bookList == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bookController!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailBookPage(isbn: currentBook.isbn13!)));
                      },
                      child: Row(
                        children: [
                          Image.network(
                            currentBook.image!,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentBook.title!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(currentBook.subtitle!),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        currentBook.price!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}

import 'package:book_store/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookService()),
    ],
    child: const BookHomePage(),
  ));
}

class BookHomePage extends StatelessWidget {
  const BookHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

final TextEditingController searchController = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookList = context.watch<BookService>().bookList;
    return Scaffold(
      appBar: _SearchAppBar(),
      body: bookList.isEmpty ? EmptyItem() : _BookList(),
    );
  }
}

//AppBar with Search Bar
class _SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final bookService = context.watch<BookService>();
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Book Store",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            right: 12,
          ),
          child: Text(
            "total ${bookService.bookList.length}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        )
      ],
      centerTitle: false,
      bottom: _searchArea(bookService),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 72);
}

// 검색 창
PreferredSizeWidget _searchArea(BookService bookService) {
  // 검색 메서드
  void search(BookService bookService, TextEditingController controller) {
    String keyword = controller.text;
    if (keyword.isNotEmpty) {
      bookService.getBookList(keyword);
    }
  }

  return PreferredSize(
    preferredSize: Size(double.infinity, 72),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "원하시는 책을 검색해주세요",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              search(bookService, searchController);
            },
          ),
        ),
        onSubmitted: (value) {
          search(bookService, searchController);
        },
      ),
    ),
  );
}

class _BookList extends StatelessWidget {
  const _BookList({super.key});

  @override
  Widget build(BuildContext context) {
    final bookList = context.watch<BookService>().bookList;
    return ListView.builder(
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        Book book = bookList[index];
        return ListItem(book: book);
      },
    );
  }
}

//리스트 아이템
class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  // 링크 이동 메서드
  void linkToPage(String link) {
    Uri uri = Uri.parse(link);
    launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        book.thumbnail,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      title: Text(
        book.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        book.subtitle,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      onTap: () {
        linkToPage(book.previewLink);
      },
    );
  }
}

// 검색 결과가 없을때
class EmptyItem extends StatelessWidget {
  const EmptyItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "검색어를 입력해 주세요",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 22,
      ),
    ));
  }
}

// // 검색가능 앱 바
// PreferredSizeWidget _searchAppBar(BookService bookService) {
//   return AppBar(
//     backgroundColor: Colors.white,
//     title: Text(
//       "Book Store",
//       style: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     actions: [
//       Container(
//         alignment: Alignment.bottomCenter,
//         padding: EdgeInsets.only(
//           right: 12,
//         ),
//         child: Text(
//           "total ${bookService.bookList.length}",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//         ),
//       )
//     ],
//     centerTitle: false,
//     bottom: _searchArea(bookService),
//   );
// }

// // 검색 결과 리스트
// class BookList extends StatelessWidget {
//   const BookList({
//     Key? key,
//     required this.bookService,
//   }) : super(key: key);

//   final BookService bookService;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: bookService.bookList.length,
//       itemBuilder: (context, index) {
//         Book book = bookService.bookList[index];
//         return ListItem(book: book);
//       },
//     );
//   }
// }

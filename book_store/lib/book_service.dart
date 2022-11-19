import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookService extends ChangeNotifier {
  // 책 목록
  List<Book> bookList = [];

  /// 검색어로 책 정보 불러오기
  void getBookList(String q) async {
    bookList.clear(); // 기존에 들어있는 데이터 초기화

    // API 호출
    Response res = await Dio().get(
      "https://www.googleapis.com/books/v1/volumes?q=$q&startIndex=0&maxResults=40",
    );
    List items = res.data["items"]; // items 접근
    for (Map<String, dynamic> item in items) {
      Map<String, dynamic> volumeInfo = item["volumeInfo"]; // volumeInfo 접근
      Book book = Book.fromJson(volumeInfo); // Map -> Book
      bookList.add(book); // Book 추가
    }

    // 화면 갱신
    notifyListeners();
  }
}

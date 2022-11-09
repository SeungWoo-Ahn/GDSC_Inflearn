import 'package:flutter/material.dart';

/// 두 번째 페이지
class StarbucksSecondPage extends StatelessWidget {
  const StarbucksSecondPage({Key? key}) : super(key: key);

  /// 카드 이미지
  final String cardImgUrl = "https://i.ibb.co/BgfYHg4/2021-12-16-1-49-51.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pay',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                print('메뉴 버튼 클릭');
              },
              color: Colors.black.withOpacity(0.4),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.85),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Image.network(cardImgUrl),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: Offset(0, 5),
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ]),
                    );
                  })),
            ),
            Container(
              height: 72,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        'Coupon',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        print('쿠폰 버튼 클릭');
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 12,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        'e-Gift Item',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        print('기프트 버튼 클릭');
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

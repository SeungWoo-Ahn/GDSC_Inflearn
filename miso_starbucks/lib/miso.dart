import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Miso 메인 색상
Color misoPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class Miso extends StatefulWidget {
  const Miso({Key? key}) : super(key: key);

  @override
  _MisoState createState() => _MisoState();
}

class _MisoState extends State<Miso> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          MisoFirstPage(),
          MisoSecondPage(),
          MisoThirdPage(),
          MisoFourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: misoPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.redeem), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

/// 첫 번째 페이지
class MisoFirstPage extends StatelessWidget {
  const MisoFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            Text(
              '대한민국 1등 홈서비스',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '미소를 만나보세요!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 38,
            ),
            GestureDetector(
              onTap: (() {
                print('예약하기 클릭');
              }),
              child: Container(
                width: 135,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: misoPrimaryColor,
                      size: 18,
                    ),
                    Text(
                      '예약하기',
                      style: TextStyle(
                        color: misoPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print('서비스 상세정보 클릭');
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Text(
                  '서비스 상세정보',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: misoPrimaryColor,
    );
  }
}

/// 두 번째 페이지
class MisoSecondPage extends StatelessWidget {
  const MisoSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            '예약내역',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1,
            ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: misoPrimaryColor,
                  size: 16,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '예약된 서비스가 아직 없어요. 지금 예약해보세요!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              print('예약하기 클릭');
            },
            child: Container(
              alignment: Alignment.center,
              color: misoPrimaryColor,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '예약하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

/// 세 번째 페이지
class MisoThirdPage extends StatelessWidget {
  const MisoThirdPage({Key? key}) : super(key: key);

  /// 세 번째 화면 배경 이미지 URL
  final String backgroundImgUrl =
      "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: misoPrimaryColor,
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Image.network(backgroundImgUrl),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 64,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '친구 추천할 때마다\n',
                        ),
                        TextSpan(
                            text: "10,000원 ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: "할인 쿠폰 지급!",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '자세히 보기',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 180,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 32),
                    margin: EdgeInsets.only(bottom: 45),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.gift_fill,
                          color: misoPrimaryColor,
                        ),
                        Text(
                          '친구 추천하기',
                          style: TextStyle(
                              color: misoPrimaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )));
  }
}

/// 네 번째 페이지
class MisoFourthPage extends StatelessWidget {
  const MisoFourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            '나의 정보',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '010-9999-9999',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.house_alt),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '주소 관리',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.creditcard),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '결제 수단 관리',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.campaign_outlined),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '공지사항',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.help_outline),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '문의사항',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

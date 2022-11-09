import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miso_starbucks/miso/common/data/color.dart';

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
              BackgroundImg(backgroundImgUrl: backgroundImgUrl),
              Column(
                children: [
                  SizedBox(height: 64),
                  HeaderText(),
                  SizedBox(height: 35),
                  DetailIcon(),
                  Spacer(),
                  RecommendButton()
                ],
              )
            ],
          ),
        )));
  }
}

class RecommendButton extends StatelessWidget {
  const RecommendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style:
                TextStyle(color: misoPrimaryColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class DetailIcon extends StatelessWidget {
  const DetailIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({
    Key? key,
    required this.backgroundImgUrl,
  }) : super(key: key);

  final String backgroundImgUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Image.network(backgroundImgUrl),
      ),
    );
  }
}

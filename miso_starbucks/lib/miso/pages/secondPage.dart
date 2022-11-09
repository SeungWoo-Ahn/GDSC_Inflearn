import 'package:flutter/material.dart';
import 'package:miso_starbucks/miso/common/data/color.dart';

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
          SizedBox(height: 60),
          HeaderText(),
          SizedBox(height: 60),
          HeaderBox(),
          Spacer(),
          ReserveButton()
        ],
      ),
    ));
  }
}

class ReserveButton extends StatelessWidget {
  const ReserveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class HeaderBox extends StatelessWidget {
  const HeaderBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(width: 15),
          Text(
            '예약된 서비스가 아직 없어요. 지금 예약해보세요!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '예약내역',
      style: TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

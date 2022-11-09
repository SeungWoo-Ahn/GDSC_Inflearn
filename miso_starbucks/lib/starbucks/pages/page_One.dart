import 'package:flutter/material.dart';
import 'package:miso_starbucks/starbucks/common/data/color.dart';
import 'package:miso_starbucks/starbucks/common/data/imgUrl.dart';
import 'package:miso_starbucks/starbucks/common/data/listData.dart';

/// 첫 번째 페이지
class StarbucksFirstPage extends StatelessWidget {
  const StarbucksFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                StarBucksBar(),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frequency(),
                      SizedBox(height: 32),
                      RecommendText(),
                      SizedBox(height: 32),
                      ReccomendList(),
                      EventCard(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
            DeliveryCard(),
          ],
        ));
  }

  Positioned DeliveryCard() {
    return Positioned(
      bottom: 18,
      right: 24,
      child: GestureDetector(
        onTap: () {
          print('딜리버리 클릭');
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: starbucksPrimaryColor,
            borderRadius: BorderRadius.circular(64),
          ),
          child: Row(
            children: [
              Text(
                "Deliverys",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.pedal_bike_outlined,
                color: Colors.white,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding EventCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          eventImg,
        ),
      ),
    );
  }

  SizedBox ReccomendList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          final menu = recommendMenu[index % recommendMenu.length];
          final name = menu["name"] ?? "이름";
          final imgUrl = menu["imgUrl"] ?? "";
          return SizedBox(
            width: 128,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(imgUrl),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding RecommendText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
                text: "안승우",
                style: TextStyle(
                  color: starbucksAccentColor,
                )),
            TextSpan(text: "님을 위한 추천 메뉴"),
          ],
        ),
      ),
    );
  }

  Padding Frequency() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          frequencyImg,
        ),
      ),
    );
  }

  SliverAppBar StarBucksBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      snap: false,
      floating: true,
      expandedHeight: 252,
      backgroundColor: Colors.white,

      //스크롤 시 사라지는 영역
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            HeaderBackImg(backImg: backImg),
            //배경 위 위젯
            HeaderText()
          ],
        ),
      ),

      //스크롤 시 남아있는 영역
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: UnderHeader(),
      ),
    );
  }

  Container UnderHeader() {
    return Container(
      height: 52,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 12,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("what's new 클릭");
              },
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 32,
            ),
            GestureDetector(
              onTap: () {
                print("쿠폰 클릭");
              },
              child: Row(
                children: [
                  Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: Colors.grey,
                  size: 32,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: starbucksPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
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
    return Positioned(
      left: 24,
      right: 24,
      bottom: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '한 해의 마무리,\n 수고 많았어요',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '11 until next Reward',
                      style: TextStyle(
                          color: starbucksAccentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        value: 0.083,
                        minHeight: 10,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          starbucksAccentColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '1',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' / ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: '12 starts',
                      style: TextStyle(
                        color: starbucksAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderBackImg extends StatelessWidget {
  const HeaderBackImg({
    Key? key,
    required this.backImg,
  }) : super(key: key);

  final String backImg;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 60,
      child: Image.network(
        backImg,
        fit: BoxFit.fill,
      ),
    );
  }
}

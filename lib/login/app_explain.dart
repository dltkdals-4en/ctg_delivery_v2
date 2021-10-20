import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/login/input_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class AppExplain extends StatelessWidget {
  const AppExplain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List swiperList = [
      '커피 투고가 빠르고 쉽게\n수거를 도와드려요',
      '매일 해야 할 수거업무를\n확인할 수 있어요',
      '최적의 경로를 통해\n수거를 도와드려요',
      '회원가입은 별도의\n문의가 필요해요!',
      '환경을 생각하는 커피 투고로\n자원 순환을 실천해보세요'
    ];
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/subLogo.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Swiper(
                      loop: false,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/illust${(index + 1)}.png',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              swiperList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: swiperList.length,
                      pagination: SwiperPagination(
                        builder: SwiperPagination.dots,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputPhoneScreen(),
                          ));
                    },
                    child: Container(
                      width: size.width,
                      height: 60,
                      child: const Center(
                        child: Text(
                          '커피 투고 시작하기',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      side:
                          const BorderSide(width: 1, color: CoColor.coPrimary),
                      primary: CoColor.coPrimary,
                      elevation: 0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

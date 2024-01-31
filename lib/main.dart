import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // runApp : 앱 구동 명령어, MyApp 메인 페이지
}

// Custom Widget **매우 중요**. (만약 굉장히 긴 레이아웃 용 위젯 들이 너무 많아 진다면..? 한 단어로 깔끔 하게 축약 가능.) @stless 사용
/*
1. 커스텀 위젯은 class로 만든다. (class: 변수 및 함수 보관함)
2. 커스텀 위젯 되려면 변수와 함수를 많이 넣어야 하는 상황. 만약 직접 작성하면 길어지니. 이미 완성된 위젯 복사: class 만드는 방식. extends로 상속 받아 사용.
3. const super.key는 어떤 파라미터 넣을 수 있는지 정의하는 부분.
4. build는 JavaScript는 function 함수명() 이런식으로 만들었다. 하지만, build로 작성하여 함수를 생성.
5. build 내의 return에 축약할 위젯을 넣어서 사용.
6. override를 통해 extends받아 재정의 하는 구조.

7. State 관리 힘들어지고,



*/
class ShopItem extends StatelessWidget {  // 클래스명 작성
  const ShopItem({super.key});

  @override
  Widget build(BuildContext context) {  // return에 축약하고싶은 레이아웃 작성
    return SizedBox(
      // 만약 스크롤 바 필요한 긴 문장이면.. Column이 아닌 ListView를 사용해야함. (스크롤 위치 감시 또한 가능 (controller), 메모리 절약을 통한 성능 개선)
      child: Text('안녕'),

    );
  }
}


class MyApp extends StatelessWidget {
  /*const*/ MyApp({super.key});

  var a = 1;

  @override
  Widget build(BuildContext context) {
    // 메인 페이지 디자인 등 .. 실질 적인 코드 작성 위치
    return MaterialApp(
        home: Scaffold(
            /*
                 ** 버튼에 기능 부여하는 법
                 floatingActionButton 항상 child, onPressed가 필요함.
                 onPressed: 항상 (){}이 세트.
             */
            floatingActionButton: FloatingActionButton(
              child: Text(a.toString()),  // a++ 이 되더 라도 버튼 명은 안바뀜. (재 랜더링이 안되어서 그렇다.)  재 랜더링:
              onPressed: (){
                print(a);
                a++;
              },
            ),
            appBar: AppBar(),
            body:
            /*
            ListView(
              children: [
                ListTile(
                  leading: Image.asset('Capture001.png'),
                  title: Text('홍길동'),
                )
              ],
            )
             // 만약 이같은 코드를 100번 반복할 것인가? 반복문 존재. (ListView.Builder)
             */
          ListView.builder( // * 매우 중요 *
              itemCount: 5, // 몇번 반복 생성할 것인지 ?
              itemBuilder: (context, iterator){  // 반드시 파라미터 안에 파라미터 두개를 넣어야함. (iterator 위젯 반복 생성마다 +1)
                // return Text(iterator.toString());  // text내에는 문자만가능
                // print(iterator); // sout 과 같이 print 가능하다. 디버깅 잘 활용할 수 있음.
                return ListTile(
                  leading: Image.asset('Capture001.png'),
                  title: Text('홍길동'),
                );
              },
          )

        ),
    );

        // 꼭 알아야하는 위젯 4가지
        /*
    * 글자위젯
    * Text('안녕')

    * 이미지위젯  이미지 등록후 사용해야함 pubspec.yaml에 등록하여야한다.
    * Image.asset('경로~~')

    * 아이콘위젯
    * Icon(Icons.아이콘이름)

    * 박스위젯
    * Container( width: 50, height: 50, color: Colors.blue ) // Flutter 의 사이즈 단위는 LP (1.2cm)
    *
    * Center(
        child: Container( width: 50, height: 50, color: Colors.blue )
      )
      * 이와 같은 child는 부모 하위에 시작할 위치를 지정해주기 위함.
    *
    * SizedBox()
     */

        // Scaffold 위젯을 상단 중단 하단으로 나누어 표현하기 위한 위젯.
        /*
    Scaffold(
        appBar: AppBar(),
        body: Container(),
        bottomNavigationBar: BottomAppBar(),
      )
    */

        // 여러가지 위젯 가로로 배치하는 방법 // 세로는 Column //  mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center 등 정렬 자연스럽게 사용
        /*
    Row(
          children: [Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)]
        )

    Row(
          children: const [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star)
              ]
        )
    */

        // 가운데 정렬
        //     mainAxisAlignment: MainAxisAlignment.center,   // dispaly : flex와 매우 유사
        //     children: ...

      /*
      bottomNavigationBar: BottomAppBar(
              child: SizedBox(  // Container 대용품
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.phone),
                    Icon(Icons.message),
                    Icon(Icons.contact_page)
          ],
        ),
      ))
      */

      // 디자인
      /*
      Scaffold(
            appBar: AppBar(
              // leading: Icon(Icons.star), title: Text('title test')    // leading : 메뉴바,
              actions: const [Icon(Icons.star),Icon(Icons.star),Icon(Icons.star),Icon(Icons.star)], title: Text('title test'),
            ),
            body:  Align(   // Center( // 센터의 자식으로 컨테이너 만들기
              alignment: Alignment.topCenter,  // 센터가아닌 다른 정렬 방식 Align 하위에 alignment 선언
              child: Container(
                width: 50, height: 50,  // , color: Colors.red, // 폭을 double.infinty 는 무한을 의미함. 단, 부모 크기의 하위 만큼 까지만..
                margin: EdgeInsets.all(20), // 전체여백 20 // fromLTRB 함수는 동서 남북 개별 마진
                // padding: EdgeInsets.all(20), // 바깥여백 20
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black) // 박스 데코레이션 켜면 상위 Color를 박스 데코레이션에 넣어야한다.
                ), // 찌끄레기 속성은 모두 여기에
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(  // Container 대용품
                /* 폰트 디자인
                child: Text('아ㅑㄴ녕하세요',    // 글자디자인 방법
                  style: TextStyle( color: Colors.red, fontSize: 30 ) // color: Color(0xffaaaaaa) 와 같이 16진수로 가능. 혹은, Color.fromRGBO 함수로 사용 가능.
                                          // letterSpacing 자간  // backgroundColor // fontWeight: FontWeight.w100 글자 두께 등 .. 다양한 폰트 스타일 가능.
                            // font 뿐 아니라 color, size 가능.
                ),
                 */

                child: ElevatedButton(    // TextButton, IconButton, ElevatedButton 택 1
                  child: Text('글자버튼'),  // IconButton( icon: Icon(Icons.star), onPressed: (){} ) 와 같이 아이콘 버튼도 가능하다.
                  onPressed: (){},  // 클릭 이펙트
                  style: ButtonStyle(), // 버튼 디자인

                ),

      ))

       */


    /*
    MaterialApp(
        home: Scaffold(
            appBar: AppBar(),
            body: Row(
              children: [ // 폭을 %로 설정하려면 ? Flexible()로 감싸야한다.
                Expanded(flex: 3, child: Container(color: Colors.blue,)), // 본인만 flex: 1 있으면 본인만 커짐 (Greedy 함)
                Flexible(flex: 3, child: Container(color: Colors.green)),
                Container(width: 100, color: Colors.yellow),
              ],
            ),
        )

     */

    /*
    Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset('Capture001.png', width: 150,),

                  Container(  // 하단의 Row를 위한 Container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 정렬 (안되면 높이 의심 해야 함.)
                      children: const [
                        Text('카메라 팝니다'), // , style: TextStyle(), 로 폰트 수정 등 ..
                        Text('금호동 3가'),
                        Text('7000원'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end, // row 안에서 가로 축 정렬 (안되면 폭을 의심 해야 함.)
                          children: [
                            Icon(Icons.favorite),
                            Text('4')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )

     */

  }
}

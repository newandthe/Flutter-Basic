import 'package:flutter/material.dart';

// 사용자로부터 접근권한 ( 이미지 경로, 연락처 등 .. ) 허가 받는법.
import 'package:permission_handler/permission_handler.dart';
// pubspec.yaml 의 dependencies: 하위에 permission_handler: ^8.3.0

// 안드로이드는 android.app.build.gradle 파일 하단에 android {} 부분에 compileSdkVersion 숫자 혹은 문자 채워져있는지 확인 없으면 31 작성.
// android.app.src.main.AndroidManifest.xml 내부에
/*
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
와 같이 권한 허가 받을수 있음.
 */




void main() {
  runApp(
    MaterialApp(
      home : MyApp()
    )
  ); // runApp : 앱 구동 명령어, MyApp 메인 페이지
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

// State 변수 선언 (stful 자동완성) // 이후 MyApp 부분 클래스의 extends 부분에 전구를 활성화하여 StatefulWidget으로 변경하기. 이후 내부에있는 변수는 자동으로 state상태가됨.
class StateVal extends StatefulWidget {
  const StateVal({super.key});

  @override
  State<StateVal> createState() => _StateValState();
}

class _StateValState extends State<StateVal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DialogUI extends StatelessWidget {
  // !! 매우매우 중요 !! 만약 자식에서 부모에있는 MyApp의 a 변수를 가져다 쓰고 싶으면 ?? (부모 위젯의 state를 자식 위젯이 사용하고 싶다면?)
  // 원래 다른 class에 있는 변수는 지역변수이기 때문에 마음대로 가져다 사용은 불가능하다..
  // * 매우 중요 * 자식위젯에게 state를 전송할 수 있음.
  /*
  1. 부모 : 보내고
  2. 부모, 자식 : 등록
  3. 자식 : 사용

  부모 -> 자식 state 전송은 가능, but .. 자식에서 부모, 다른 자식에게도 state 전송은 불가능하다.
  따라서 중요한 state 최대한 부모 위젯에 생성해야 함.

  그렇다면 부모 state 값을 어떤식으로 수정해야하는가? 부모 위젯에서 변수를 수정하는 함수를 생성하고 호출해야한다!!!
   */
  DialogUI( {super.key, this.addOne, this.addName} );     // 자식에서 등록
  // var state;  // 부모 및 자식에서 등록한걸 선언  // const를 유지하거나 final로 변수 선언하면.. (read-only로 선언됨)
  final addOne;
  final addName;
  var inputData = TextEditingController();
  var inputData2 = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            // TextField( controller: inputData,),  // 사용자가 입력한 데이터를 변수에 담는법. controller: 변수 // 입력하면 해당 변수에 저장이 됨. // 혹은 onChanged: (){}
            // TextButton ( child: Text('완료'), onPressed:() {addName(inputData.text);} )
            TextField( onChanged: (text){ inputData2 = text;  print(inputData2);} ), // 소괄호의 text: 사용자가 입력한 값.
            TextButton(child: Text('완료'), onPressed:(){ addName(inputData2); addOne(); } ),
            TextButton(onPressed: (){Navigator.pop(context); }, child: Text('취소')),
          ],
        ),
      ),
    );
  }
}






class MyApp extends StatefulWidget {
  /*const*/ MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // 접근 권한 사용자에게 허가 받는 방법. 고정됨
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted){
      print("허락됨");
    } else if (status.isDenied) {
      print("거절됨");
    }
  }


  var name = ['김영숙', '홍길동', '피자집'];
  var total = 3;
  
  addName(value){
    setState(() {
      name.add(value);
    });
  }


  addOne(){
    setState(() {
      total++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // !! 매우 중요.  context: 커스텀 위젯을 만들 때마다 강제로 하나씩 생성됨. "the build location of the current widget"( 부모 위젯의 정보를 담고 있는 변수 )
    // 메인 페이지 디자인 등 .. 실질 적인 코드 작성 위치
    // print(context.findAncestorWidgetOfExactType<MaterialApp>()); // 확인방법
    // showDialog(context), Scaffold.of(context), Navigator.pop(context), Theme.of(context) 는 context를 입력해야 잘 동작하는 함수.
    // 이는 부모 중에 MaterialApp이 포함되어야 context를 입력해야 잘 동작한다.!! -> 따라서 main함수쪽으로 MaterialApp을 바깥으로 뺀 것.
    // 혹은 Builder로 Wrap하면 context 족보 생성..! -> Scaffold, MaterialApp 이런거 들어있다..! builder: (jokbo1) 이후 context: jokbo1 와 같이 사용.
    return Scaffold(
          appBar: AppBar( title: Text(total.toString())),
          body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (c,i){
                return ListTile(
                  leading: Image.asset('Capture001.png'),
                  title: Text(name[i]),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog(context: context, builder: (context){  // dialog는 해당 양식이 고정.
                return DialogUI(addOne : addOne, addName : addName );  // 자식위젯에게 보내는 방법. ( 작명 : 보낼state ) // 부모에서 등록
              });
            },
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
    
    /*
    Scaffold(
            /*
                 ** 버튼에 기능 부여하는 법
                 floatingActionButton 항상 child, onPressed가 필요함.
                 onPressed: 항상 (){}이 세트.
             */

            /*
            state 변수는 값이 변할 때마다 사용하는 위젯이 자동으로 재 랜더링 됨.

             */

            floatingActionButton: FloatingActionButton(
              child: Text(a.toString()),  // a++ 이 되더 라도 버튼 명은 안바뀜. (재 랜더링이 안되어서 그렇다.)  재 랜더링: 리액트의 useState와같이 state사용.
              onPressed: (){
                print(a);
                setState(() {   // 매우 중요하다 !! State는 setter를  사용하여 변경 사항을 적용해야 한다. (변수 선언자체는 일반변수와 동일.)
                  a++;
                });
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
              itemCount: name.length, // 몇번 반복 생성할 것인지 ?
              itemBuilder: (context, iterator){  // 반드시 파라미터 안에 파라미터 두개를 넣어야함. (iterator 위젯 반복 생성마다 +1)
                // return Text(iterator.toString());  // text내에는 문자만가능
                // print(iterator); // sout 과 같이 print 가능하다. 디버깅 잘 활용할 수 있음.
                return ListTile(
                  leading: Image.asset('Capture001.png'),
                  title: Text(name[iterator]),
                );
              },
          )

        )
    
     */

  }
}

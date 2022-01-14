# Segue
Date : 20.01.14
// 스토리보드(인터페이스 빌더)에서 **뷰 컨트롤러** 사이의 연결 관계, **화면전환**을 하는 역활이다.
이전에 공부했던 Navigation Controller에서 루트 Navigation Controller가 해당 뷰 컨트롤러한테 붙는 화살표 또한 (관계형)세그웨이다.
//세그웨이는 출발지와 목적지가 존재한다.
// 세그웨이를 이용할 경우 뷰 컨트롤러에 대한 정보가 없어도 된다. 
 => 즉 뷰 컨트롤러 class에서 대상 객체의 인스턴스를 생성하지 않나도 된다는 말이다.
- - - 왜 ??
- - - - `세그웨이는 목적지인 뷰 컨트롤러의 인스턴스를 자동으로 생성하기 때문이다. 이러한 특성때문에 Segue를 통한 화면 되돌아가기는 사용하면 오류가 발생한다. (기존 ViewController가 하나 더 생성되거든,,== 뷰 컨트롤러의 인스턴스는 하나 이상 존재하면 안된다!!)`

 // 사용자의 이벤트를 전달받아 화면 전환의 매개체 역할을 한다! (but 코드 구현을 하지 않아도 된다. 그것이 장점. 하지만 장점이자 단점인 것은 기능이 제한되어있기에 custom으로 Segue를 구현하는 방법이 있다.)
//사용법 ctrl ->대상 ViewController

//장점 : 화면전환 대상을 파악하기 쉽다.


- action Segue
- Unwind //되돌아가다. 복귀
되돌아갈 VC(ViewController)에 @IBAction 액션 메서드 unwindToVC( _ segue: UIStoryboardSegue){} 메서드를 작성후 되돌아가려는 새로운 VC에 버튼만들고  exit 와 트리거 연결하면 **우리가 정의한 unwind 메서드를 선택할 수 있다?**how?
- - ->`그 이유는 우리가 이전에 만들었던 메서드중 UIStoryboard타입의 인자값을 받는 액션 메서드를 모두 수집하기 때문에 선택할 수 있는 것이다.. 대박...`
//이를 이용해서 특정 페이지로 되돌아갈 수 있다. 되돌아갈 원하는 특정 페이지에 UIStoryboard를 인자값으로 하는 unwind 액션 메서드를 정의하고 마지막 페이지나 특정 페이지에서 exit 와 트리거연결하면된다. 참고로 이때 특정 페이지에 되돌아갈려면 해당 Viewcontroller에 대한 ViewController class 정의해야 하는거 알지? ㅎㅎ
- custom Segue
- 전처리 메서드(prepare for segue: UIStoryboardSegue, sender: Any?){}

## action Segue

> 다른 말로 트리거 라고 한다. ( **터치, 클릭 event** 발생시켜 세그웨이를 실행할 수 있는 요소!

위에서 표기한 사용법으로 present 화면전환 효과도 나타낼 수 있다.
( Action Segue -> Present Modally) // 뷰 컨트롤러 자신이 새로운 화면을 불러들이도록 처리.

내비게이션 컨트롤러 관련 뷰 컨트롤러라면 Action Segue -> Show 옵션을 선택할 경우 Navigation controller 효과가 부여된다. (내비게이션 바에 뒤로가기 버튼 생성)
-> 만약  내비게이션 컨트롤러와 관련이 없는데 Show 옵션을 선택할 경우에는 그냥 Present Modally 화면전환이 적용된다.


## custom Segue

이 경우는 UIStoryboardSeuge를 상속받는 클래스를 정의한 후에, 그 클래스 안에 *override func perform() {}* 메서드를 구현하는 것이다. 구현할 때 출발지, 목적지를 정해주어야 한다! 참고로 이들의 타입은 UIViewController이다.

또한 전처리 메서드 prepare의 경우 세그웨이가 실행되기 이전에 특정 메서드(prepare)을 호출 할 수 있게 한다.

근데 prepare(전처리 메서드)의 경우 여러 세그웨이가 공유?!한다 (static 느낌..) 근데 인자값으로 segue: UIStoryboardSegue를 통해 어떤 뷰 컨트롤러가 호출하는지 알 수 있으므로 switch문 등 조건문을 통해서 특정 세그웨이가 호출 될 경우 이에 대한 특별한 처리를 하고 싶으면 하면된다!


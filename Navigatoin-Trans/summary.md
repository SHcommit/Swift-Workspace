Date : 20.01.13
# 화면 전환 -Navigation Controller

사용법.
- shift + cmd + L 에서 navigation controller를 스토리 보드에 드래그한다.
- 스토리보드에 디폴트 View Controller를 이용한 방법
> => 이 경우는 디폴트 View Controller를 Embed in  처리해서 Root Navigation Controller로 정의하는 것이다.

Embed In 처리를 한 경우 
기존 *View Controller*는 *Root Navigation*과 연결된다. (지목당한다?)
따라서 Scnen(View Controller속 화면)에 **Navigation Controller**가 추가된다.

참고로 Root Navigation인 Navigation Controller는 처음 Embed In 처리를 통해 연결된 View Controller에 대해서 그냥 지목만 해주는 것 같다,,(나 지금 얘랑 연결되있어 이런 느낌?)
따라서 Next Page는 **shift + cmd + L**을 통해 새로운 View Controller를 스토리보드에 추가해야한다.

// 첫 화면에서 새로 정의한 화면(Storyboard ID : SecondVC)으로 넘어가는 **두 가지 방법**

1. Navigation Title에  **Shift + cmd + L(라이브러리 팝업창)**에서 Navigation Item 을  추가합니다. (네비게이션 아이템 위에서 네비게이션 타이틀이 작동되기 때문)
 
다음으로 넘어갈 버튼을 네비게이션 타이틀에 추가합니다.(Bar Button Item) 이때 오른쪽에 선언하는게 좋다. *그 이유는 네비게이션 버튼을 통해 다음 Scene로 이동 할 경우 네비게이션 특성에 의해 자동으로 네비게이션 바와, " Navigation Title명 "으로 구현된 뒤로가기 버튼이 자동으로 추가되기 때문이다.*

2. 네비게이션 바 아래 일반 Scene에서 present 메서드를 통해 화면 전환 할 버튼  객체를 추가하는 방법입니다.

이 경우를 통해 이동하면 Root Navigation에 의해 연결된 Scene이라 할 지라도 두번째 Scene은 일반 Scene로 된다. 따라서 Navigation Bar 가 생기지 않고, Navigation Back Button 도 인식되지 않는다.

1. 의 경우에서 디폴트로 생성되는 뒤로가기 버튼을 이외에 추가적으로 버튼을 구현하고 싶다면.

두번째 Scnen 에서 추가적인 버튼 추가와, 해당 Scene에 대한 View Controller class를 선언, 구현해야합니다. 

**여기서 중요한 것은**

- **present** 는 해당 *ViewController*자체를 호출하는 것이다.

- **pushViewController**는 *NavigationController*가 스토리보드 내에 선언되어 있다면, Navigation Controller를 호출 시켜 해당 메서드가 호출되는 것이다.

추가적으로

**Navigation Controller**는 *pushViewController()* 메서드를 통해서 첫번째 인자값으로 받은 ViewController 인스턴스를 Navigation 스택에 push 하면서 Navigation 특성을 자동으로 할당한다??.
 화면 전환된 해당 Scnen에 대해서 다시 원래 위치로 화면 전환을 할 경우 *popViewController()* 메서드를 사용한다. 
이때 이 메서드는 **Navigation 스택의 top**에 위치한 ViewController 인스턴스를 제거하면서 되돌아간다는 점이다.

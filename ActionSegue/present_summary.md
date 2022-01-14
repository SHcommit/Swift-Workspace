# 프레젠트 메서드로 화면 전환
- call View Controller // 프레젠트 메서드 이용한 경우.
이 경우는 `present 메서드를 사용한 화면 전환은 기존의 뷰 컨트롤러VC1을 그대로 둔 채 그 위에 새로운 뷰 컨트로러VC2의 화면을 덮는 방식!`
//화면 전환시
	- present(_: animated:) 메서드를 사용하는 방법.
-> 첫번째 인자값 == 화면 전환될 new View Controller
-> 두번째 인자값 == 전환 시 애니메이션 여부
//이전화면으로 되돌아갈 때
	- dismiss(animated:)
**이전화면**으로 되돌아간 다는 것은. 기존 화면을 덮고 있던 새 화면을 걷어낸다. *이후 걷어낸 화면의 뷰컨트롤러는 운영체제에 의해 메모리 해제된다.*

다시 말해서. VC1 에서 present(_: animated:) 메서드를 통해 VC2를 화면에 표시해주었다면. VC2가 화면에서 사라질 때도 **VC1의 권한**이 있어야 한다.

`아니.. 이전화면 없어지고, 이미 새로운 화면으로 온거 아니야? `
> 틀렸습니다.

VC1에서 VC2로 전환될 경우. VC1은 VC2(새로운 화면)에 대해서 presentedViewController을 통해서 현재 화면에 출력되고 있는 VC2에 대한 참조를 할 수 있다.

VC2에서 VC1로 화면 전환될 경우, VC2는 VC1(현재 출력되는 Scene)에 대해서 presentingViewController을 통해서 참조할 수 있다.

다시 말해 새로운 화면으로 전환되어도 서로 참조가 가능하다는 말은 이전화면이 없어지면 참조가 될 수 없다는 말..

`그렇다면 VC2인 화면에서 VC1로 화면 전환은 어떻게 할까?... `
VC2일 경우 presentingViewController속성을 통해 VC1을 참조할 수 있음으로, *VC1 뷰 컨트롤러에 대해서 새로운 인스턴스를 생성하지 않고도* VC1을 참조하고 있는 presentingViewController을 이용하면 쉽게 VC1의 정보를 알 수 있다!! 돌아가기도 쉽다는 말씀. 

`그렇다면 VC2인 화면에서 presnet메서드를 이용해서 VC1을 호출하면 안되는가? `

> 안됩니다. 이미 참조되고있는 VC1이외에 새로운 VC1이 화면을 덮는 것이기 때문에 (new)VC1 , VC2 , (old)VC1 이 세개의 장면이 겹치게 됩니다. (이전의 VC1은 메모리 해제가 되지 않고 남아있다. why? presentingViewController?.dismiss(animated:)메서드를 통해 VC1을 부르지 않았으니까..)

- VC2에서 돌아가는 방법?
`printingViewController 속성을 이용해서 뒤로간다는것은 알겄는디 우째 써야해? `
	- 버튼을 추가하자!! 그리고 @IBAction을 통해 VC class에서 메서드로 연결해서 뒤로가기 기능을 구현하면 되자너~
`VC2 (새로운화면) 에 대한 클래스가 object C로 구현되어있다. 뭐지?`

이럴때는 해당 object C로 구현된 UIViewController를 상속받는 클래스를 정의하고, 해당 클래스 명을 VC2 뷰 컨트롤러 속성에서 커스텀 클래스 명으로 등록하면 된다잇!@ 
 그 후 presentingViewController (VC1 참조중) 이거 써서 dismiss.. 알지? 
 

**//요약**.
**// (화면을 덮는것이다! 기존 VC 존재한다! 사라지지 않는다.)**
// 화면 전환 present(_ : animated:) //이전 화면 복귀 dismiss(animated:)
**//차이점은 presnet메서드는 새로운 뷰 컨트롤러에 대한 인스턴스를 필요로한다.** 
// present를 통해 화면 전환 할 경우 presnetedViewController (새로운 VC 참조) , presentingViewController (원래 VC 참조 가능) 속성이 생기고. 이전화면 복귀 시 presentingViewController을 통해 dismiss를 사용해야한다.
`(물론 present 메서드를 쓰기 위해선 인스턴스가 필요한데, 이는 stroyboard에 존재할 것이고, instantiateViewController메서드를통해 새로운 VC의 Storyboard ID값과 일치하는 뷰 컨트롤러를 찾고, 이를 인스턴스화한다!)....
(그리고 또 한가지.. storyboard는 옵셔널 타입이어서 . nil값일 경우 인스턴스 생성되지 않게 옵셔널 바인딩을 적용 하도록!`


# UIAlertController

앱 사용자에게 알림 메세지를 전달 할 때![:bowtie:](https://github.githubassets.com/images/icons/emoji/bowtie.png ":bowtie:")(똑똑)
## 알림창이란?

사각형의 박스 안에서 알림 문구의 메세지와 함께 확인, 취소 등 버튼을 통해 의사표현 하는 창
- UIAlertController : **앱 안**에서 특정 메세지를 알림 형식으로 전달 할 때!
	- 액션 시트 ( 모달 형식 x) _ 버튼을 세로로 배치
	- 알림창 (모달 형식 o ) _ 버튼을 가로로 배치
### :star::star::star:모달(modally)형식이란?
- 특정한 화면이 모달 형식으로 열렸을 경우 그 화면이 닫히기 전 까지는 다른 부분의 화면, 창은 반응할 수 없는 형식. ( 사용자는 버튼을 통해 해결해야 한다)




## UIAlertController 특징
- 사용자와 상호작용하는 용도로 자주 사용된다(yes or no)
- 경고, 확인 문구의 알림 메세지가 전달 되기도 한다.
- UIAlertController는 :sparkles:**ViewController**:sparkles: 의 일종이다. 
	- 즉 알림창을 나타낼 때는 present(_:animated:)메서드를 통해 뷰 컨트롤러를 화면에 present 해야한다.
- **알림창**(모달 o)을 만들 경우 UIAlertController의 세번째 매개변수 preferredStyle에 UIAlertController.Style.alert 를 입력한다.
	- alert . 알람창
		- 모달 형식이다.
=> 알람창 **뷰 컨트롤러**:star: 화면이 출력되면, 알람창이 **포커스 온** 되서 알람창 에서만 이벤트 발생과 이에 대한 변화가 발생된다. 
- **액션 시트**(모달 x)을 만들 경우 UIAlertController의 세번째 매개변수 preferredStyle에 UIAlertController.Style.actionSheet 를 입력한다.
	- 만약 세번째 매개변수 **prefferedStyle**에 인자값을 할당하지 않을 경우 **디폴트값**으로 **actionSheet** 스타일이된다.  
### :star::star::star::star: UIAlertAction 알림창 안에 버튼을 추가할 때
UIAlertAction(title: "<버튼 이름>", style: <버튼 실행 타입>,handler : nil )<or { ( _ ) in ... } // 클로저>
- 첫번째 인자값에는 버튼 이름
- 두번째 매개변수 style에 대한 인자 값은 버튼 실행 타입
	- case .default
		 - 일반적인 버튼 .default
	- .cancel
		 - 이때 cancel은 알림창 내 **한번만** 사용 가능하다
	- .destructive
		- 중요한 내용 변경, 삭제될 때의 버튼에 적용시킨다. 이때 색은 빨간색:exclamation:이다.
- 세번째 매개변수 handler는 사용자가 버튼을 클릭했을 때 세번째 매개변수에 전달된 클로저가 실행된다. 
	- 여기서 메세지 창의 text구문 내용도 바꾸고 다양한 작업 가능.

UIAlertAction 인스턴스 생성후 

알람객체.addAction( <UIAlertAction인스턴스>) 인스턴스를 알람 객체에 추가 한다.

그 후 **화면 전환**을 한다! 

**UIAlertController 또한 ViewController의 일종**이기 때문이다. self.present(알람객체, animated: false)

그러나 삭제할 때는 dismiss(animated:) 구현 x 해도 된다. 버튼 클릭시 창 자동으로 닫히기 때문.

//추가적으로 앱이 시작될 때 알림창을 띄우고 싶다면
 1. viewDidLoad()
 2. viewDidAppear(_:)
어느 곳에 알림 변수를 선언해야 할까?

2 번 viewDidAppear(_:)에 해야 한다. 

1번의 경우 런타임 에러가 난다. ( 초기 화면 구성이 되지 않은 상태에서 present() 화면전환을 시도했기 때문.

따러서 viewDidAppear()에 해야햔다.

### 참고로 런타임과 컴파일의 개념이란?
- 컴파일 : 개발자가 입력한 소스 코드를 기계어로 변환되는 과정(실행 가능한 프로그램이 된다.)
- 런타임 : 컴파일 이후 사용자에의해 실행되고, 프로그램이 동작된다.


## 알림창 선언, 출력하는 코드 
https://github.com/SHcommit/Swift-Workspace/blob/master/AlertControllerStudy/AlertControllerStudy/ViewController.swift

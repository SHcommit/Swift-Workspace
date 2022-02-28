# 로컬 알림 UserNotification
앱이 실행 중일 뿐 아니라, 앱이 종료되어있을 때도 '알림'을 발송할 수 있다. 이 점이 UIAlertController과 다른 점이다.
- 로컬 알림은 **한개의 프레임워크**이다. //import UserNotifications

그래서 앞에 UN이라는 줄임말이 붙는다. UserNotifitcation에서 가장 중요한 객체는
1. UNMutableNotificationContent	
	- *Mutable*이란 단어가 많이나온다 ( 변할 수 있는). 
	- 알림의 기본적인 속성()을 추가할 수 있기에 Mutable 이란 단어가 붙는다.  알림 메세지 이름 내용 등 UIAlertController()같은 느낌.
2. UNTimelntervalNotificationTrigger // 시간 간격!! Trigger
	- 알림 발송(시간) 조건 메서드이다.  (몇 분 후, 몇 번?) . 입력 단위 : 초
3. UNNotificationRequest
	- 2에서 좀 더 구체적으로 시간까지 지정한 알림에 대해서 UNNofiticationRequest의 인자값으로 할당한다. 그렇게 된다면 알림 요청 객체가 생성된다.
4. UNUserNotification**Center**
	- 수정 불가. 오르지 (구현한) 객체만 읽을 때. == 등록된 알림 콘텐츠를 찾으려면 MutableNotificationContent를 사용해야 한다.
	- 이 객체는 **싱글턴** 방식으로 동작한다.
		- 싱글 턴이란
			-  : 전역(Static)으로 접근 가능한 공유 클래스 인스턴스(한개의 객체를 여러 객체에서 호출_reference) 만드는 패턴.
	- 위에서 만든 알림 에 대해서 current( ) 메서드를 통해 참조 정보를 가져 올 수 있다. 

이외의 객체 UNCalenderNotificationTrigger 
	: 특정 시각에 알림 전송하고 싶을 경우 사용된다.

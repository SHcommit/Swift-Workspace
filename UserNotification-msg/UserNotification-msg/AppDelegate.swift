//
//  AppDelegate.swift
//  UserNotification-msg
//
//  Created by 양승현 on 2022/01/20.
//

import UIKit
import UserNotifications

//UNUserNotificationCenterDelegate 프로토콜 추가.
@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {


    /*앱이 처음 시작 할 때호출하는 메서드.(디폴트 VC가 모바일 화면에 띄워지기 전에 실행된다.
     * 로컬 푸쉬 알람을 사용하기 위해서는 UNUserNotificationCenter 객체를 이용해
     * 미리 알람 설정 환경을 정의하고, 이 설정을 사용자에게 동의 여부를 받아야 알람 발송이 가능하다.
     * 사용자가 allow버튼을 클릭하지 않으면 알람 발송해도 해당 상대방에게 전송X
     wow,,
     
     *requestAuthorization()이 메서드를 통해 사용자로부터 알람 설정 승인여부를 물어볼 수 있다.
     */
    /*
     *앱 실행 도중 알림메세지 발생할 경우
       userNotificationCenter(_:willPresent:withCompletionHandler:)메서드가 자동으로 호출된다.
     *앱이 실행중이던 아니던 사용자가 알림 메세지에 대한 이벤트를 발생시킨 경우
       userNotificationCenter(_:didReceive:withCompletionHandler:)
     -> 이 메서드는 위에서 추가한 UNUserNotificationCenterDelegate 프로토콜에 정의되어 잇다.
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 10.0, *){
            let notiCenter = UNUserNotificationCenter.current(); //미리 알람 설정 환경 정의!
            
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]){(didAllow, e) in}
            
            notiCenter.delegate = self;
            /*이제 앱 델리게이트 클래스는 사용자가 알림 메시지 클릭 이벤트 전달받을 수 있다.
             *알림창에서 사용자가 이벤트를 발생시키면 appDelegate가 catch할 수 있다!!
             *앱 델리게이트가 알림창의 이벤트를 감지 할 수 있게 됨.
             */
        }else{
            /*
             *Date : 20.01.21
             *UILocalNotification
             */
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting)// 어플리케이션에 위에서 선언한 알림 인스턴스를 추가하는 코드.
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    //앱이 활성화 상태를 잃었을 때 실행되는 메서드.
    //ex 우선순위먼저인.. 전화나 문자, 재난경보 지원, 홈버튼 등등
    //이때 applicationWillResignActive메서드가 호출된다.
    func applicationWillResignActive(_ application: UIApplication)
    {
        //여기에서 UN 프레임워크를 이용한 로컬 알림 동의 여부를 확인한다.
        if #available(iOS 10.0 , * ){
            UNUserNotificationCenter.current().getNotificationSettings { settings in //인자값으로 settings가.
            if settings.authorizationStatus == UNAuthorizationStatus.authorized //만약 settings의 허가 상태가 허가됬다면? 아래 코드 실행.
            {
                //알람 정보가 담긴 콘텐츠 인스턴스 생성.
                let nContent = UNMutableNotificationContent();
                //앱 아이콘 위에 알람 정보 표시(읽지않은 알림 1개 존재한다)
                nContent.badge = 1;
                // title, subtitle모두 알림이 진행되면 출력되는 메세지 정보들. (body 까지)
                // subtitle은 종종 생략 ,
                // but title, body는 거의 항상 사용됨.
                nContent.title = "Local msg push"
                nContent.subtitle = "5분만 더 있으면 '불타는 의지' 칭호를 획득 할 수 있어요!"
                nContent.body = "앗 , 왜 나가셨어요? 어서 들어와요"
                //알림이 울릴 때 출력되는 사운드.
                nContent.sound = UNNotificationSound.default
                //로컬알림이 울릴 때 전달될 값이 있을 경우에 사용한다.
                //앱 델리게이트에서 참조 가능하다.
                //만약 사용자가 입력한 이벤트에 대한 이벤트함수를 구현할 때 특정 알림에 대한 name를 print하면 "길동이" 출력됨.
                nContent.userInfo = ["name ": "길동이"]
                
                /*알림 발송 조건 객체
                 *TimerInterval 몇 초 뒤에 발송 예정?
                 */
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                //알림 요청 인스턴스
                //이 인스턴스는 추후 특정 알람 요청 취소할 때도 사용된다.
                let request = UNNotificationRequest(identifier : "wakeup", content: nContent, trigger: trigger);
                
                //UN...Center에 등록된 알림 내용을 iOS 스케줄링 센터에 등록하고, 정해진 시간에 발송함.
                UNUserNotificationCenter.current().add(request);
                }else{
                print("사용자가 동의하지 않음")
                }
            }
        }else{ //iOS  9이하는 UserNotification 프레임워크 적용 안된다!
            //UILocalNotification 으로 알림 정의해야한다.
            let setting = application.currentUserNotificationSettings //알림 설정값 읽어온다.(인스턴스)
            guard setting?.types != .none else { // 사용자가 알림 여부 파악
                print("작동안함")
                return
            }
            let noti = UILocalNotification() //로컬알림의 새 인스턴스 생성하고 !! 아래 코드를 통해 인스턴스 속성 정의후!!
            noti.fireDate = Date(timeIntervalSinceNow :10) //10초후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent //현재 시간을 바탕으로 자동 업데이트.
            noti.alertBody = "얼릉 다시 접속해!!"
            noti.applicationIconBadgeNumber = 1 //앱 뱃지 알림 1로 설정
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.userInfo = ["name" : "길동이"]
            
            application.scheduleLocalNotification(noti)     //여기 application에 넣음으로써 iOS스케줄러에 등록이 된다.
            
        }
    }
    
    //사용자로부터 발생된 알림창 이벤트 에대한 헨들러 메서드 구현해보자!
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center : UNUserNotificationCenter, willPresent notification: UNNotification, withCompletioinHandler completionHandler: @escaping (UNNotificationPresentationOptions)->Void){
        if notification.request.identifier == "wakeup" { //아까 위에서 구현한 알람 요청 인스턴스 식별 ID를 구현한 알림 식별함.
            let userInfo = notification.request.content.userInfo; //사용자가 커스텀 한 정보 읽어와서 함수 내 지역변수에 저장
            print(userInfo["name"]!) //위에서 userInfo에 정의된 name에 대한 길동이 출력!
        }
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup"{
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler();
    }
    //두번째 외부 매개변수 명을 보면 willPresent 앱이 실행 중일 때 알림 메세지가 도착한다면, 알림 배너 표시관계 상관없이 userNotification메서드가 실행된다.
    //두번째 외부 매개변수 명이 didReceive는 입이 실행 중 일 때, 발생된 알림창을 사용자가 클릭 이벤트를 발생하면 willPresent메서드가 실행된다.
    //알림 메세지에 대한 인스턴스는 두번째 인작값 responsive, notification에 전달된다.!
    //따라서 didRecenve 인자값의 함수일 경우 사용자가 특정 이벤트를 발생시키면 이에 대한 기능을 userNotificationCenter(_ :  didReceive :...)에서 구현하면 된다.
}

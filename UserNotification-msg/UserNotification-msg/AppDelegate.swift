//
//  AppDelegate.swift
//  UserNotification-msg
//
//  Created by 양승현 on 2022/01/20.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    /*앱이 처음 시작 할 때호출하는 메서드.(디폴트 VC가 모바일 화면에 띄워지기 전에 실행된다.
     * 로컬 푸쉬 알람을 사용하기 위해서는 UNUserNotificationCenter 객체를 이용해
     * 미리 알람 설정 환경을 정의하고, 이 설정을 사용자에게 동의 여부를 받아야 알람 발송이 가능하다.
     * 사용자가 allow버튼을 클릭하지 않으면 알람 발송해도 해당 상대방에게 전송X
     wow,,
     
     *requestAuthorization()이 메서드를 통해 사용자로부터 알람 설정 승인여부를 물어볼 수 있다.
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *){
            let notiCenter = UNUserNotificationCenter.current();
            
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]){(didAllow, e) in}
        }else{
                
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
            UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized
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
        }
    }
}

//
//  ViewController.swift
//  UserNotification-msg
//
//  Created by 양승현 on 2022/01/20.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var msg: UITextField!
    @IBOutlet var datepicker: UIDatePicker!
    
    /*
     DispatchQueue.main.async란?
     백그라운드에서 실행되는 로직을 메인 thread에 실행되도록 처리해주는 역활을 한다.
     //알림 또한 UI 뷰 컨트롤러의 일종이기 때문에 main 스레드에서 처리되어야 한다.
     따라서 알림에 관한 구현을 DispatchQueue.main.async로 처리를 한다.
     */
    @IBAction func save(_ sender: Any) {
        if #available(iOS 10, *){
            //UserNotification 프레임워크로 구현.
            
            UNUserNotificationCenter.current().getNotificationSettings { //사용자가 허락을 했는지 매개변수 settings을 if 문으로 비교해서 알아보자!
                settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    // 알림 타이틀, 알람음, 언제 알람발송되는지 등등 구현
                    DispatchQueue.main.async{
                        
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리 알림"
                        //subtitle 은 생략해도됨,,
                        nContent.sound = UNNotificationSound.default
                        
                        //발송 시각을 지금부터 ~초 형식으로 전환,,
                        let time = self.datepicker.date.timeIntervalSinceNow
                        
                        //발송 조건 정의?!
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats :false)
                        
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                        
                        //아직 알림의 형태, 이름,등에 대한 구현을 하지 않았다.
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                let date = self.datepicker.date.addingTimeInterval(9*60*60)
                                let message = "알림 등록되었습니다. 등록된 알림은 \(date)에 발송됩니다."
                                //알림 내용 추가
                                let alert = UIAlertController(title:"알림등록", message: message, preferredStyle: .alert)
                                
                                //버튼 추가
                                alert.addAction(UIAlertAction(title: "확인", style: .default))
                                
                                //알림 호출
                                self.present(alert, animated: false)
                            }
                        }
                    }
                    
                }else{
                    //사용자가 알람을허락하지 않았다는 알람창을 추가했음(명시적으로 사용자에게 한번 알려주기위해).
                    let alert = UIAlertController(title: "알림등록",message: "알림 허용되어 있지 않았습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    
                    self.present(alert, animated: false)
                    return;
                }
                
            }
        }else{
            //10 이하는 UILocalNotification 클래스로 구현.
        }
    }
    
}


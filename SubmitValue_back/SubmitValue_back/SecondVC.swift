//
//  SecondVC.swift
//  SubmitValue_back
//
//  Created by 양승현 on 2022/01/17.
//

import Foundation
import UIKit

class secondViewController : UIViewController{
    
    
    @IBOutlet var tfEmail: UITextField!
    
    @IBOutlet var isUpdate: UISwitch!
    
    @IBOutlet var interval: UIStepper!
    
  
    @IBOutlet var showUpdate: UILabel!
    
    @IBOutlet var showInterval: UILabel!
    
    @IBAction func onSwitch(_ sender: Any) {
        let sender = sender as? UISwitch
        if sender?.isOn == true {
            self.showUpdate.text = "갱신완료"
        }else {
            self.showUpdate.text = "갱신안됨"
        }
    }
    @IBAction func onStepper(_ sender: UIStepper){
        showInterval.text = "\(Int(sender.value))분 마다";
    }
    
    
    /*
     VC1 은 presentingVC 속성을 통해서 VC2 참조 가능
     VC2는 presentedVC 속성을 통해 VC1 참조 가능하다.
     
     *참고로 self.presentingViewController를 통해
     VC를 인스턴스화 할 경우 UIViewController 타입을 갖는 인스턴스가 생성된다.
     하지만 우리가 정의한 멤버변수는 위의 타입을 상속받는 자식 클래스 ViewController에 존재한다.
     따라서 self.present~를 통해 인스턴스를 얻은 경우
     * 업 캐스팅된 인스턴스라 할 수 있다.*
     정의된 자식객체 멤버변수까지 사용하기 위해선 다운캐스팅을 해야한다. ( as 연산자)
     */
    @IBAction func onSubmit(_ sender: Any) {
        /*
        let VC1 = self.presentingViewController;
        guard let prevVC = VC1 as? ViewController else { // 다운캐스팅
            return
        }
        //위의 경우가 잘못된 이유?
        //  => 다른 클래스의 아울렛변수에 직접 값을 삽입 불가능!
        //prevVC.editEmail = self.tfEmail.text;
        prevVC.VC1email = self.tfEmail.text
        prevVC.VC1update = self.isUpdate.isOn
        prevVC.VC1interval = self.interval.value;
        */
        
        // AppDelegate 인스턴스를 사용하는 경우
        /*
         AppDelegate 인스턴스는 앱 전체에서 단 한개의 인스턴스만 존재하도록 ios에 설정되어있다.
         ( = 싱글톤?)
         // 따라서 클래스의 인스턴스를 직접 생성x
         UIApplication.shared.delegate 를 통해 현재 생성된 AppDelegate 인스턴스를 참조해야 한다.
         */
        /*let ad = UIApplication.shared.delegate as? AppDelegate
        
        ad?.paramEmail = self.tfEmail.text
        ad?.paramUpdate = self.isUpdate.isOn
        ad?.paramInterval = self.interval.value
         */
        
        //또 다른 방법으로 키 값을 전달하는 경우
        // 프레임워크에서 제공하는 UserDefaults 를 사용하는 방법
        // ( 이 객체르 통한 값 삽입, 삭제는 앱이 삭제되기 전까지 반 영구적으로 유지된다.
        
        
        //UserDefaults.standard 프로퍼티를 사용해서 읽거나 작성해야 한다.
        // set(_:forKey:)메서드를 사용한다.
        // 기존 값의 형변환 필요 없이 저장하고, forKey를 통해 특정 key값에 저장된 값을 불러올 수 있다.
        let ud = UserDefaults.standard
        
        ud.set(self.tfEmail,forKey: "email")
        ud.set(self.isUpdate.isOn, forKey : "isUpdate")
        ud.set(self.interval, forKey: "interval")
        
        self.presentingViewController?.dismiss(animated: true)
        
        
    }
    
    
}

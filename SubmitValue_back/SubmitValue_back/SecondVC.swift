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
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

//
//  ViewController.swift
//  TextFieldDelegate
//
//  Created by 양승현 on 2022/01/22.
//

import UIKit
/**
 *텍스트 필드에 대해서 Delegate 패턴 적용
 *ViewController에 UITextFieldFelegate 프로토콜 선언한다.
 *이미 UIViewController를 상속받고 있기에 옆에 " , "로 선언이 가능하다.
 * self.tf.deelgate = self 코드를 통해 tf에 delegate를위임하고, UITextFieldDelegate 프로토콜에 구현된 메서드를
 * 추가 구현해 작성하도록 하자!
 */
class ViewController: UIViewController , UITextFieldDelegate{
    
    //tf에 대한 추가 정의. VC출력되기 전에 버튼이나 텍스트필드 속성 여기서 정의하자.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tf.placeholder = "값을 입력하세요" //텍스트 입력 없을시 표기됨.(얕게)
        self.tf.keyboardType = UIKeyboardType.alphabet //열거형! 키보드타입 알파벳
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.returnKeyType = UIReturnKeyType.join //리턴 키 타입 join
        self.tf.enablesReturnKeyAutomatically = true //리턴키 자동활성화 O
        
        /*
         tf 스타일 설정
         */
        self.tf.borderStyle = UITextField.BorderStyle.line
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0);
        
        self.tf.contentVerticalAlignment = .center //Vertical 수직 방향 text 정리
        self.tf.contentHorizontalAlignment = .center //Horizon 수평방향 text 정리
        self.tf.layer.borderColor = UIColor.darkGray.cgColor; //테두리 색상 회색
        
        self.tf.layer.borderWidth = 2.0 //테두리 두께
        
        //텍스트 필드가 UIWindow에서 tf로 최초 응답자로 지정되어야 자동으로 키보드가 나온다.
        self.tf.becomeFirstResponder() // tf 최초 응답자 지정
        
        /**
         * tf 에. 델리게이트 패턴 적용하기
         * 텍스트 필드의 delegate  = self는
         * tf에 특정 이벤트가 발생했을 경우 알려줄 대상객체를 가르키는 속성이다.
         * 대상 객체는 self (지금 현재 ViewController)이다.
         * 다시말해,
         * 뷰 컨트롤러가 텍스트필드의 델리게이트 객체로 지정되었다.
         *
         * delegate(위임하다!) tf가 self(ViewControoer)에게!! 그렇다면 tf에서 발생될 특정 이벤트는
         * 자신의 객체에게 델리게이트 메서드를 통해 이벤트가 발생함을 알려준다.
         */
        self.tf.delegate = self;
    }
    @IBOutlet var tf: UITextField!
    
    /**
     *tf에 최초응답자가 설정되어, 키보드가 내려가 지지 않는다.
     *이 경우는
     *1. 키보드에 값 입력->return키
     *2. 화면상의 다른 컨트롤을 클릭해서 최초 응답자를 다른곳으로 옮기거나.
     *3. resignFirstResponder()메서드를 호출 할 수 있는 컨트롤을 구현하고, 그것을 누름으로써 최초 응답자 해제를 한다.
     */
    @IBAction func confirm(_ sender: Any){
        self.tf.resignFirstResponder() //특정 컨트롤 최초 응답자 해제
    }
    
    @IBAction func inputTf(_ sender: Any){
        self.tf.becomeFirstResponder() //특정 컨트롤 최초 응답자 선언!
    }
    
    
    /**
     *UITextFieldDelegate 프로토콜에 구현된 메서드 활용하기~
     *참고로 이 메서드들 대부분?이 bool타입이다. return true를 해야 특정 메서드명에대한 실행이된다.
     *첫번째 함수. 텍스트 필드가 클릭된 후 최초 응답자가 되기 전에 수행되는 메서드
     *두번째 함수. 사용자가 텍스트 필드의 내용 삭제 이벤트를 발생했을때 호출되는 메서드
     ***세번째 함수**. 사용자의 액션으로 인해 텍스트 필드의 내용이 변경 될 때 호출됨,,(**예를들어 키보드 누를때마다 tf 창이 변하잖아 그럼 이 함수가 출력된다.. 신기)**
     *4번째 함수. 텍스트필드 리턴키가 눌릴 때!!! 사용자의 입력이 끝난 상태이기 때문에 Responder를 해제하는 구문이들어가야,,
     *5. tf 편집 종료될 때
     *6. tf 편집 종료된 후. 호출되는 메서드
     ***한가지 신기한 것은 리턴 키를 누를 때 5,6, 4 순으로 함수 실행이 진행 된다는 것이다.**
     */
    //1
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드 편집이 시작된다!!")
        return true;
    }
    //2
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용 삭제된다..")
        return true;
    }
    //3
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드 내용이 \(string)으로 변경된다.")
        return true
    }
    //4
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Focus 해제
        print("텍스트 리턴키 눌려졌음");
        return true;
    }
    //5
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드 편집 종료될 예정,,,,")
        return true;
    }
    //6
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드 편집 종료")
    }
}


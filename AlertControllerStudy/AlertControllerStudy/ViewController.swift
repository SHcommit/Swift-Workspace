//
//  ViewController.swift
//  AlertControllerStudy
//
//  Created by 양승현 on 2022/01/19.
// 알람창 실행 되면 결과를 표시할 레이블을 만들 프로젝트입니다.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var alertResult: UILabel!
    
    
    
    /* 알림 메세지 style =.alert 로 알림창을 만들기 위한 메서드입니다.
     alert . 알람창
     -모달 형식이다.
     => 알람창 뷰 컨트롤러 화면이 출력되면, 알람창에 포커스 온 되서 알람창 만 이벤트 발생과 이에 대한 변화가 발생된다.
     
     UIAlertController.preferredStyle은
     UIAlertController클래스에 preferredStyle에 대한 열거형 선언을 위해
     추가적으로 확장을해서 정의를 했다.
     case actionSheet = 0
     case alert = 1
     선언된 열거형의 호출의 경우
        타입이 명확하면.case명 으로 호출하면 된다.
     
     UIAlertController()의 초기값을 부여할 경우, 알람창의 전체적인
     모양을 설정한다.
     이후에 확인, 취소 등의 액션 이벤트는 추가적으로
     UIAlertAction 인스턴스를 생성 후 위에 알람창 인스턴스.addAction() 인자값으로 방금 생성한 인스턴스를 대입하면 된다.
     그리고, 알람창 또한 뷰 컨트롤러의 일종이어서 present()를 통해 화면 전환을 한다.
     */
    @IBAction func alert(_ sender: Any) {
        //액션 시트의 경우 prefferedStyle에 액션 시트로 변경하면된다.
        //폰 사용하면서 액션 시트 타입을 더 많이 본듯?,,
        let alert = UIAlertController(title: "선택", message: "항목을 선택해 주세요", preferredStyle: .alert)
        
        //취소 버튼 인스턴스 생성과 알람창에 추가.
        let cancel = UIAlertAction(title: "취소", style: .cancel){(_) in self.alertResult.text = "취소 버튼 눌렀다~" }
        alert.addAction(cancel);
        
        //확인 버튼 인스턴스 생성과 알림창에 추가.
        let ok = UIAlertAction(title:"확인", style:.default){(_) in self.alertResult.text = "확인 버튼 클릭!"}
        alert.addAction(ok)
        //실행
        alert.addAction(UIAlertAction(title: "실행", style: .destructive)
                        {(_) in self.alertResult.text = "실행 버튼 눌렀다."});
        //중지
        alert.addAction(UIAlertAction(title: "중지", style: .default){(_) in self.alertResult.text = "중지 버튼 클릭했다."});
        
        //다음장으로 넘어가볼게!!
        alert.addAction(UIAlertAction(title: "다음 창", style: .destructive){(_) in
            /*우선 이렇게 두번째 VC에 대한 인스턴스를 만드는데!!
              * 주의할 점이 *
             instantiateViewController는 인스턴스 생성시
             타입형은 UIViewController이다.
             근디!!!
             나는 UIViewController을 상속받아서 SecondVC 클래스를 구현했기 때문에!!!! as연산자를 통해
             SecondVC로 다운 캐스팅 해야 내가 구현한 SecondVC 클래스 전체에 대한 인스턴스를 사용할 수 있다.
            */
            guard let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else {
                return
            }
            // 추가적으로 "SecondVC" 인자값은 클래스 명이 아니고!!!!!! storyboard ID값이다 ㅋㅋㅋ !!
            self.present(SecVC, animated: true);
        });
        
        self.present(alert,animated: false);
    }
    
    /*화면이 뜨자마자 알림창 실행 후 화면 출력여부를 보여줄 경우!
     *아래 두 가지중 한가지 택 할 수 있는데
     *viewDidAppear의 경우는 아직 메세지 창을 처리할 뷰가 화면에 구현되지 않은 초기에 viewDidAppear메서드를 실행하기 때문이다.
     *따라서 viewDidLoad()메서드를 사용해야 한다. 알림창을 실행하기 전에는 뷰 가 구현되야 한다.
     */
    //override func viewDidAppear() {}
    //override func viewDidLoad(_ animated : Bool){}
    
    
    
    // 알람창 안에 Text Field를 통해 애플 아이디가 맞나 확인차 비번을 받아볼 것이여!!
    
    @IBAction func loginBtn(_ sender: Any) {
        let title = "Store 로그인 창"
        let message = "사용자의 Store ID topdeveloper@gmail.com의 암호를 입력하세요"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default){(_) in
            if alert.textFields?[0].text == "1234"{
                self.alertResult.text = "인증되었습니다."
            }else{
                self.alertResult.text = "인증 실패!"
            }
        })
        //알람창에서의 텍스트 필드 추가는 addTextfield를 이용한다. 인자값으로 tf에 대한 텍스트 필드 속성을 구현하는 것이다.
        alert.addTextField(configurationHandler: { (tf) in tf.placeholder = "암호"
            tf.isSecureTextEntry = true
        })
            //만약 textfield의 0번째 에 문자열이 입력 되었을 경우, nil이 아닌 옵셔널 값이 tf에 대입된다.
        if let tf = alert.textFields?[0] {
            print("입력 값 \(tf.text!)입니다.")
        }else{
            print("입력값이 없습니다.")
        }
        
        
        self.present(alert, animated: false);
    }
}


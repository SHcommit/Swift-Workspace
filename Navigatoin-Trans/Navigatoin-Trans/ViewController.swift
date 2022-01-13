//
//  ViewController.swift
//  Navigatoin-Trans
//
//  Created by 양승현 on 2022/01/13.
//  Divide develop branch

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
     아래 매서드는 Nevigation Bar에서 추가적으로 부착한 Bar Button Items에 대한 이벤트 메서드이다.
     조건문이 거짓일 경우 실행되는 guard 조건문을 사용했다.
     if 로 쓸 경우 !(조건)하면 되는데,, 빨리 익숙해지고 싶다.
     
     자신(View Controller class)과 연결되어있는
     storyboard에서 instantiateViewController메서드를 이용해
     "SecondVC" 스토리보드 ID값을 찾은 후 객체화하여 uvc에 저장한다.
     = 다시말해 두번째 Scene를 다룰 수 있도록 인스턴스화한다.
     */
    @IBAction func nextScene(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return;
        }
        //다음 화면으로 이동한다.
        //어떤 화면? uvc라는 스토리 보드 ID값을 인스턴스로 갖는 변수 uvc
        self.navigationController?.pushViewController(uvc, animated: true)
        /*self.navigationController?
        /이 코드는 우선 자신(View Controller class) 클래스에 연결된 뷰 컨트롤러 스토리보드 안 특정 Scene에 대해서
         연결이 되어있다면, 그 Scene에 내비게이션 컨트롤러가 있다면
         내비게이션 컨트롤러 클래스 안에 있는 push메서드를 실행할 것이다.
         self.navigationController?.가 nil을 반환한다면?
         Scene에 내비게이션 컨트롤러는 추가되있지 않음을 알 수 있다.
        */
    }
    //내비게이션 바 에서 구현한 버튼말고 그 아래 일반 Scene 에서 다음 화면으로 넘어가기  버튼(present)을 구현했다.
    @IBAction func movePresent(_ sender: Any) {
        guard let testUvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC")else{
            return;
        }
        self.present(testUvc, animated: true);
    }
    //이 결과 다음 화면으로 성공적으로 이동했을 때는 네비게이션 바와 자동 생성된 바 뒤로가기 버튼이 존재하지 않는다.
    /*
     따라서 네비게이션 컨트롤러가 추가되어있다고 하지만, 네비게이션 바 item으로 정의한 버튼을 이용하여 화면 전환을 하지 않은 경우,
     Next Scene은 네비게이션 컨트롤러의 제어하에 있지 않다.
     => 다시말해서 동일한 뷰 컨트롤러에서 화면 전환하는 방식 2가지
     (1번째는 네비게이션 컨트롤러 안에 정의한 bar item)
     (두번째는 그냥 Scene에서 일반 버튼을 통해 화면 전환하는 방식)
     이 두가지 중 첫번째의 경우 pushViewController(_: animated:)메서드를 호출한 결과
     네비게이션 스택에 뷰 컨트롤러 SecondVC객체를 추가했기 때문에 두번째 SecondVC객체도 내비게이션 컨트롤러의 제어가 가능했다.
     - 아니면 추가적으로 popViewController()메서드 구현해야한다.
     
     하지만 두번째 경우는 그렇지 않다.
     오직 present 메서드를 통해서 화면을 전환해야 한다.!!!!!!!
     
     */
}


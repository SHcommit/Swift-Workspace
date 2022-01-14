//
//  ViewController.swift
//  SubmitValue
//
//  Created by 양승현 on 2022/01/14.
//

import UIKit

// 궁금해서 해당 Outlet 변수들 타입 어노데이션 되는 UI~들 살펴봤는데
// 다 클래스네?.,,. 그래서 isUpdateText 등 쓸수있는거였음.
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //tf
    @IBOutlet var email: UITextField!
    
    //switch ctrl
    @IBOutlet var isUpdate: UISwitch!
    
    //stepper ctrl
    @IBOutlet var interval: UIStepper!
    
    //show switch state
    @IBOutlet var isUpdateText: UILabel!
    
    //show stepper state
    @IBOutlet var intervalText: UILabel!
    
    //switch 값이 바뀔 경우 아래 메세지 헨들러 호출
    @IBAction func onSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            self.isUpdateText.text = "갱신 완료"
        }else{
            self.isUpdateText.text = "갱신 안됨"
        }
    }
    
    //stepper 값이 변결 될 경우 아래 메세지 헨들러 호출
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    //인터페이스 빌더 액션 메서드를 생성할 때 인자값으로 특정 UI클래스 or Any로 받는 두가지 방법이 있다.
    
    //UI~~를 인자값으로 받는 경우 캐스팅을 하지 않아도 되지만,
    //Any로 인자값을 받는 경우 ,특정 컨트롤에 대한 하위 클래스로 캐스팅을 해야한다.
    // * 이미 특정 UI타입이 Any 타입인 sender에 업캐스팅 되었다면, 이제 as연산자를 통해 특정 UI타입으로 다운 캐스팅을 해야 한다능,,
    //ex) let obj = sender as? UISwitch .
    
    
    @IBAction func submitBtn(_ sender: Any) {
        //아, 참고로 storyboard 안에 있는 VC중에 storyboard ID 가 SecondVC와 일치하는 ID가 있는지 찾고 있을경우 인스턴스화 하는거 알쥐?
        let trueCase : Int = 2;
        switch (trueCase){
        case 1:
        guard let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            print(" 두번째 뷰 컨트롤러 인스턴스 안 만들어졌다!")
            return
        }
            break;
        case 2:
            guard let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVicwController else {
                return;
            }
            SecondVC.paramEmail = self.email.text!
            SecondVC.paramUpdate = self.isUpdate.isOn
            SecondVC.paramInterval = self.interval.value
           // 원래 present였는데,
            // NavigationController 로 바꿔서
            // present 말고 내비게이션일때 화면전환 쓸거임(push함수)
           // self.present(SecondVC, animated: true);
            
            //화면 전환!
            //-> SecondVC에서 돌아올 때는 presentingViewController 에 있는
                //dismiss 이용하면됨.
            self.navigationController?.pushViewController(SecondVC, animated: true)
            
            break;
        default:
            print("No");
            break;
        }
        //case 0의 경우.
        //일단 storyboard의 insetantiateViewController메서드를 이용해서 특정 VC를 인스턴스로 만들 경우. 이 VC의 타입은 UIViewController이다. 업 캐스팅이 된 셈이다.
        //하지만 지금 이번 주제에서는 특정 VC의 프로퍼티에 지금 VC에서 갖고 있는 값을
        //대입 시키는 것이 목적이다.
        //하지만 업 캐스팅된 인스턴스는 자식객체에서 만든 프로퍼티를 사용할 수 없다. 따라서
        //case 2 의 경우처럼 VC객체를 찾고 인스턴스화 한 후 as? 자식객체! 를 통해서
        //다운캐스팅 후 해당 프로퍼티에 값을 넣는 것이다.
        //근데 다운 캐스팅의 경우 오류가능성이 존재해서 옵셔널 바인딩으로 처리해야 좋다!
        /* 다운 캐스팅 as 키워드! */
        
    }
    
    @IBAction func onPerformSeuge(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self);
        //이 경우 prepare() 전처리 메서드를 통해 프로퍼티값을 Update한다.
        
        //헐 근데 prepare메서드는 인자값으로 VC인스턴스 받게되어있는데,
        //세그웨이쓸 때는 알아서 연결될 인스턴스가 자동으로 생성되는데 우쩌지..?
        //override를 통해 그 인자값의 타입 캐스팅을 하자.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let mySecVC = segue.destination as? SecondVicwController else{
            return
        }
        mySecVC.paramEmail = self.email.text!
        mySecVC.paramUpdate = self.isUpdate.isOn
        mySecVC.paramInterval = self.interval.value;
    }
    
}


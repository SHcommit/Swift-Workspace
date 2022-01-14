//
//  SecondVC.swift
//  SubmitValue
//
//  Created by 양승현 on 2022/01/14.
//

import Foundation
import UIKit


class SecondVicwController : UIViewController{
    
    //viewDidLoad메서드는
    //시스템에서 화면이 메모리에 로드되고 난 직후 viewDidLoad() 메서드를 호출해 준다.
    override func viewDidLoad() {
        //물론 여기 아울렛 변수에 직접 값을 대입할 수 없다.
        //따라서 VC1에서 VC2의 프로퍼티에 값을 대입시킨 후 present(_: animate:)함수를 호출 했기에,
        //VC2의 프로퍼티는 실시간 변경된 값이 존재한다.
        self.page2Email.text = paramEmail
        self.page2Update.text = (self.paramUpdate == true ?  "자동갱신" : "자동 갱신x")
        self.page2Interval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    @IBOutlet var page2Email: UILabel!
    
    @IBOutlet var page2Update: UILabel!
    
    @IBOutlet var page2Interval: UILabel!
    
    /*헐랭.. 위에 아울렛 변수로 대입받으면 되지 뭘 굳이,, 라는 생각을 했는데
     아울렛 변수는 외부에서 값을 직접 대입할 수 없는 변수래.
     시스템에 의해(컴파일 시점?) 값이 주입된다.
     또한 아울렛 변수는 외부 객체에서 직접 참조할 수 없도록 제한되어 있다.
     헉;;;
     그래서 아래처럼 프로퍼티를 만드는구만? //o.o\\
    */
    var paramEmail: String = "";
    var paramUpdate: Bool = false;
    var paramInterval : Double =
    0.0
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated:true)
    }
    
    
    
    
}

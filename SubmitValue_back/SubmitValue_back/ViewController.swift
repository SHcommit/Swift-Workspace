//
//  ViewController.swift
//  SubmitValue_back
//
//  Created by 양승현 on 2022/01/16.
//


//VC 1 -> VC2로 할 경우 viewDidLoad에서 작성하면된다.
//하지만 VC2 -> VC1 로 할 경우는?
//viewWillApear(_ :)메서드를 호출한다.
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBOutlet var editEmail: UITextField!
    
    @IBOutlet var editUpdate: UITextField!
    
    @IBOutlet var editInterval: UITextField!
    
    var VC1email : String?
    var VC1update : Bool?
    var VC1interval : Double?
    
    /* viewWillAppear(_ animated: Bool) 메서드는 다른 화면으로 기존 VC를 가렸다가 기존 VC를 호출 할 경우
     * 이 메서드가 호출된다.
     * 처음 VC가 화면에 나타날 때도 ViewDidLoad() ->viewWillAppear(_ :)가 호출된다.
     */
    override func viewWillAppear(_ animated: Bool){
        if let email = VC1email{
            editEmail.text = email;
        }
        if let update = VC1update{
            editUpdate.text = update == true ? "자동갱신" : "자동갱신안함";
        }
        if let interval = VC1interval{
            editInterval.text = "\(Int(interval))분마다"
        }
        print("viewWillApear 호출됬다~")
        //현제 이 메서드가 VC2로갔다 VC1로 되돌아올 때  호출이 안되는 것 같다. 왜그런지 모르겠다.
        //틀린부분이 없는 것 같은데.. 첫 생성시에 print메서드가 호출되는 거로보아 작동이 되긴하는데 ....
    }
}


//
//  ViewController.swift
//  TableView-useDefaultVC
//
//  Created by 양승현 on 2022/02/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
/**
 *인터페이스 빌더에서 기본 VC(ViewController)를 사용하는 경우,
 *tableViewController를 사용할때의 클래스에서 디폴트로 추가된 UITableViewDataSource, UITableViewDelegate
 *두 프로토콜을 추가해해야 한다.*
 */
extension ViewController: UITableViewDataSource{
    
}
extension ViewController: UITableViewDelegate{
    
}


//
//  SecondVC.swift
//  AlertControllerStudy
//
//  Created by 양승현 on 2022/01/20.
//
// 알람창에서 다음 페이지 누를 경우 이 UIViewController 클래스랑 연결된 뷰 컨트롤러가 호출되도록 한 이후에
//취소키 누르면 첫 페이지로 갈 수 있도록 추가 구현을 할 것이다.
import Foundation
import UIKit

class SecondVC : UIViewController {
    
    @IBAction func returnBtn(_ sender: Any){
	//간단하게..
        self.presentingViewController?.dismiss(animated: true);
    }
}

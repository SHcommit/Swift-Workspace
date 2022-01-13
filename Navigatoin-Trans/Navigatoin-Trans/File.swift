//
//  File.swift
//  Navigatoin-Trans
//
//  Created by 양승현 on 2022/01/13.
//

import Foundation
import UIKit

//네비게이션 컨트롤러에 의해 Second Scene를 추가했다. 하지만
//네비게이션 바에서 자동으로 생성해주는 바에서 뒤로가기 버튼말고,
//추가적으로 뒤로가기 버튼을 따로 구현하고 SecondVC에 대한 View Controller class 를 만들있지만.
//아무런 반응이 없다;
class SecondViewController : UIViewController{
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //디폴트 네비게이션 바 뒤로가기 버튼 말고!
    //내가 그냥 구현하고 싶은데? ?
    
    
    @IBAction func NavigationBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

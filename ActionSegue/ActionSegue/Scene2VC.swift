//
//  Scene2VC.swift
//  ActionSegue
//
//  Created by 양승현 on 2022/01/14.
//

import Foundation
import UIKit

class SecondViewController : UIViewController{
    
    //Scene 2로 돌아가기 위한 Unwind메서드. 참신기하네..
    //마지막 페이지에서 추가적인 버튼을 ctrl & drag to exit 으로 하면.(세그웨이 연결방식)
    // 옵션이뜨는 데 거기서 내가 만든 Unwind 메서드 를 클릭하면 알아서 연결이된다. 구체적인 경로를 보고싶다.
    //디버깅을배워야지..ㅠ
    @IBAction func backToScene2(_ segue : UIStoryboardSegue){}
    
}

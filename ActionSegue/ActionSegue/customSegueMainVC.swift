//
//  customSegueMainVC.swift
//  ActionSegue
//
//  Created by 양승현 on 2022/01/14.
//

import Foundation
import UIKit

class cSegueMainVC : UIViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NSLog("세그위이가 곧 실행됩니다.");
        //전처리 메서드.
        //나쁘지않네, Log 기록이 특정 세그웨이 시작할 때 콘솔창에 뜨네,,
        switch segue.identifier{
        case "Navigation_segue":
            NSLog("네비게이션 세그웨이 실행된다이~")
        case "my_custom_segue":
            NSLog("그냥 정의한 디폴트커스텀 세그 실행 된다있~")
        case "custom_action_segue":
            NSLog("엑션 세그로 정의한 세그 실행 된다규~")
        default:
            NSLog("알수없는 세그입니다. ㅎ..해킹을 의심해봐야.. 하겄는디..?")
        }
    }
}

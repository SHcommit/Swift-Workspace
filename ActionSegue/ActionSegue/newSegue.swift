//
//  newSegue.swift
//  ActionSegue
//
//  Created by 양승현 on 2022/01/14.
//

import Foundation
import UIKit


//this is custom segue.
// 출발 ViewController와, 목적지 ViewController에 대해서, UIView.transition()메서드를 통해 구현한다.
//캬.. 깔끔하고 잘만들었네 swift
class myNewSegue : UIStoryboardSegue {
    override func perform(){
        // Segue's start View Controller
        let srcUVC = self.source
        
        //Segue's arrive View Controller
        let destUVC = self.destination
        
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 1.3, options: .transitionCurlDown)
    }

}

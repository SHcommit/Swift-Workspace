//
//  ListViewController.swift
//  TableCellHeight
//
//  Created by 양승현 on 2022/01/26.
//

import Foundation
import UIKit

class ListViewController: UITableViewController{
    //테이블 뷰 셀의 특정 목차에 출력될 배열
    var list = [String]()
    @IBAction func add(_ sender: Any){
        /**
         *1.  알람이 실행 될 수 잇는 큰 틀. AlertController 선언하기
         *2. 알람에 추가될 버튼의 이름을 정의하기 UIAlertAction으로
         *3. 1에서 선언한 UIAlertController 인스턴스.addAction(버튼 인스턴스) 추가하기.
         *하지만 난 2번과정을건너뛰고 3번에 바로 addAction에 매개변수에서 추가한다.
         *      **alert의 textField에 사용된 .placeholder란?*
         *          - .placeholder란? 입력 필드에 표시되는 안내 메세지
         *          - 값이 비어 있을 경우에만 입력필드에 표시되고, 값을 입력하는 순간 자동으로 사라진다.
         *          - 사용자의 입력을 가이드해주는 용도.
         */
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert);
        //매개변수를 클로저로 작성.
        alert.addTextField(configurationHandler: ){ (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        /**
         *ok 버튼 (구현시 마지막에 버튼 클릭에 대한 액션 정의 o )
         *reloadData()메서드
         *이 메서드는 테이블 뷰를 갱신한다.
         *테이블 뷰에 정의 되어있는 메서드로, 데이터 소스를 다시 읽어와 목록을 갱신한다.(어디? 테이블 VC에)
         */
        let ok = UIAlertAction(title: "OK", style: .default){ (_) in
            if let title = alert.textFields?[0].text{
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        alert.addAction(ok)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil));
        
        self.present(alert, animated: false)
    }
    /**중간요약
     *지금까지의 상황은 Navigate Controller에 버튼을 추가해 알림창을 호출시키고,
     *그 알림창의 tf에 문자열을 입력한 후에 확인 버튼을 누를 경우
     *텍스트 필드에 입력된 값이  list 배열에 저장된다.
     *이제 TableViewCell에 등록할 것이다.*
     */
}

//
//  ListViewController.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/04.
//

import Foundation
import UIKit

class ListViewController : UITableViewController{
    var list = [MovieVO]();
    //iOS에 몇개의 행을 생성할 건지 알려주는 메서드. 생성할 행 개수 반환함.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //배열에 list에 저장된 튜플 개수만큼.
        return self.list.count
    }
    //위에서 생성될 행 개수만큼 아래의 메서드가 실행된다. TableViewCell이 반환된다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //몇번째 행인지, indexPath.row를 통해 알 수 있다. 특정한 튜플을 row 프로퍼티에 저장
        let row = self.list[indexPath.row]
        
        //이미 만들어진 테이블 셀이 있다면 재사용 큐에서 꺼내 사용하고, 없다면 생성 후 사용한다.
        //UITableViewCell의 인스턴스가 생기는데, 나는 그걸 상속받은 MovieCell 클래스를 만든 후 그곳에 아울렛프로퍼티를 만들었음으로 다운 캐스팅 해야 내가 만든 변수 쓸 수 있어.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.decs?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

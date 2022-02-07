//
//  ViewController.swift
//  TableView-useDefaultVC
//
//  Created by 양승현 on 2022/02/07.
//  divide branch develop

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
    //행 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 7
    }
    /**
     *행 개수만큼 tableView(_: cellForRowAt:)메서드 실행됨.
     *이때 재사용 큐를 통해 cell을 IB(InterfaceBuilder)에서 찾은 후 인스턴스화함.
     *tableViewCell 스타일은 기본이므로 textLabel을 통해 글을 수정할 수 있음.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(indexPath.row)번째 데이터"
        return cell;
    }
}
extension ViewController: UITableViewDelegate{
    func tablView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("\(indexPath.row)번째 데이터 클릭됨.")
    }
}


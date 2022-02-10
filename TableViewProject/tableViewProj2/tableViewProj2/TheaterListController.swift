//
//  TheaterCell.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/10.
//

import Foundation
import UIKit
/**
 *영화관 정보 tab > tableView Cell의 클래스이다.
 *이곳에 IB(Interface Builder)의 VC(ViewController)안 Cell에서 추가한 레이블들의 아울렛 변수를 만든다. *
 */
class TheaterListController: UITableViewController {
    var list = [NSDictionary]()
    var startPoint = 0;
    
    func callTheaterAPI(){
        var sList = 100;
        let requestAPI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let type = "json"
        let urlObj = URL(string:"\(requestAPI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        do{
            //error: Use HTTPS instead or add Exception Domains
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
            do{
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                for obj in apiArray!{
                    self.list.append(obj as! NSDictionary)
                }
            }catch{
                //알람처리.  AlertController객체 만들고, addAction으로 추가 후 Controller인 alert를 present 이전화면으로 돌아간다.
                let alert = UIAlertController(title: "실패", message: "데이터 분석 실패.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
            }
            self.startPoint += sList
        }catch{
            let alert = UIAlertController(title: "실패", message: "데이터 불러오기 실패", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated : false)
        }
    }
    override func viewDidLoad(){
        self.callTheaterAPI()
    }
    /**
     *tableView(_:numberOfRowsInSection:)으로 행 개수 반환 후
     *tableView(_:cellForRowAt:)로 어느 cell인지 찾은 후에, 그 cell의 아울렛 변수에 특정 list 데이터인 obj의 값을 대입한다.
     *이때 주의할 점은 dequeueReusableCell(withIdentifier:)은 UITableViewCell로 반환한다.
     *UITableViewCell를 상속받은  TheaterCell클래스를 구현했으므로
     *캐스팅을 해야 내가 정의한 아울렛 변수를 사용할 수 있다.
     *끝!
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count;
    }
    /**
     *내가 한 실수.
     *tableViewCell에 레이블을 3개 정의했다.
     *태그와 다르게 아울렛 변수로 연결하려면 tableViewCell 타입에 맞는 클래스를 직접 만들어서 그곳에 정의 해야한다.
     *프로토타입 셀을 제어할 클래스를 직접 만들어야 한다.
     *  하지만 난 그냥 TableViewController 클래스에 만들었다. 이렇게 만드니까 아래 메서드에서 오류가 발생한다.
     *   반환값이 TableViewController라고, 반환값을 as! TableViewCell로 변경했는데 역시 당연하게 오류가 발생했다.
     *   이미 TableViewController를 상속받았기에 TableViewCell은 당연히 상속 받을 수 없다.
     *결론. TableViewCell을 타입으로하는 클래스를 한개 더 만든 후 tableviewCell IB와 연결시켜야 한다.*
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String
        
        return cell
    }
}

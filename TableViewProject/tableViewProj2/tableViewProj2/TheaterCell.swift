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
class TheaterCell: UITableViewController {
    @IBOutlet var name: UILabel!
    @IBOutlet var addr: UILabel!
    @IBOutlet var tel: UILabel!
    
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
     *UITableViewController를 상속받은  TheaterCell클래스를 구현했으므로
     *캐스팅을 해야 내가 정의한 아울렛 변수를 사용할 수 있다.
     *끝!
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count;
    }
    /**
     *내가 한 실수.
     **
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String
        
        return cell as! UITableViewCell
    }
}

//
//  ListViewController.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/04.
//

import Foundation
import UIKit

class ListViewController : UITableViewController{
    var page = 1;
    var list = [MovieVO]();
    //iOS에 몇개의 행을 생성할 건지 알려주는 메서드. 생성할 행 개수 반환함.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //배열에 list에 저장된 튜플 개수만큼.
        return self.list.count
    }
    /**
     *~~위에서 생성될 행 개수만큼 아래의 메서드가 실행된다. TableViewCell이 반환된다.~~
     *난 tableView(_: numberOfRowsInSection:)에서 반환된 행 개수 만큼 아래의 tableView(_ : cellForRowAt)가 바로 호출되면서 테이블 셀들이 다 만들어 지는 것으로 알고 있었다.
     *그래서 재사용 큐를 왜 쓰는지 제대로 이해하지 못했다.
     *하지만 재사용 메커니즘을 공부하면서, 재사용 큐를 왜 사용하는지 명확하게 알게 되었다.
     *아무리 많은 API의 데이터 소스를 테이블 셀에 추가하는 코드를 작성해도, 뷰에서 보여지는 특정 테이블 셀의 개수만큼만 tableView(_: cellForRowAt)메서드가 실행된다.
     *나머지는 대기 상태이다. 만들어지지 않는다.
     *추후 사용자의 스크롤 이벤트가 발생 시 보이지 않는 셀이 추가되어야 할 때 tableView(_: cellForRowAt)메서드가 발생한다.
     *그럼 그만큼의 추가 생성과 동시에 이전에 생성됬지만, 뷰에서 사라진 이전의 셀들은? 테이블 뷰에서 삭제된다!!!
     *그러나 재사용 큐에 등록이 된다. (정말 신기한 것 같다..)
     */
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
        
        
        //썸네일은 JSON데이터에 특정 url이 있다. 이를 받아와야한다.
        let url: URL! = URL(string: row.thumbnail!)
        let imageData = try! Data(contentsOf: url)
        
        cell.thumbnail?.image = UIImage(data: imageData)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    //self sizing
    /*override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 85
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
    /* ====   REST API를 사용한 화면 구현   ==== */
    override func viewDidLoad(){
        self.callMovieAPI()
    }
    
    @IBOutlet var moreBtn: UIButton!
    
    @IBAction func more(_ sender: Any) {
        self.page += 1
        self.callMovieAPI()
        self.tableView.reloadData();
    }
    
    
    func callMovieAPI(){
        let url = "http://115.68.183.178:2029/hoppin/movies?order=releasedateasc&count=10&page=1&version=1&genreId="
        let apiURI: URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        /**
         *hoppin과 movies와 movie는 JSON 데이터의 특정 상위 노드?의 인스턴스를 얻기위한 방법 같은데...
         */
        do{
            let apiDicitionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary;
            let hoppin = apiDicitionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            var totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            /**
             * r 변수란? movie -> REST API로 정의된 JSON 데이터의 하위 데이테인, movie배열에 Dictionary를 한개의 원소로하는 movie배열의 한 원소 타입 : Dictionary인 한개의 원소이다.
             * 따라서 row as! NSDictionary로 캐스팅하는 것이다.
             * 그 후 Dictionary의 키값을 호출하면 그에 해당하는 영화 정보를 얻을 수 있다.
             */
            for row in movie{
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                //초기에 여기서 JOSN객체의 movie배열의 원소만큼 list에 추가하면, 이제 tableView메서드들이 호출된다.
                self.list.append(mvo)
                totalCount = 25 ; //원래 REST API에 저장된 totalCount == 4266개이다.
                if self.list.count >= totalCount {
                    self.moreBtn.isHidden = true;
                }
            }
        }catch {
            NSLog("error!")
        }
    }
}

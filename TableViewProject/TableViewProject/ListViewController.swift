//
//  ListViewController.swift
//  TableViewProject
//
//  Created by 양승현 on 2022/01/24.
//
import Foundation
import UIKit

class ListViewController : UITableViewController{
    //var list = [BookIbVO]()
    //뷰가 나타났을 때
    //override func viewDidLoad(){
       // var bookIb = BookIbVO();
        /**
        bookIb.title = "커리어 스킬"
        bookIb.author = "존 슨메즈"
        bookIb.detail = "완벽한 개발자 인생 로드맵"
        bookIb.genre = "Computer Science"
        bookIb.rating = 9;
        
        self.list.append(bookIb); //책 정보 추가
        
        bookIb = BookIbVO();
        bookIb.title = "Clean Code"
        bookIb.author = "로버트 C.마틴"
        bookIb.detail = "이 책은 더 나은 코드를 만들려고 애쓰는 프로그래머, 소프트웨어 공학도, 프로젝트 관리자, 팀 리더, 시스템 분석가가 반드시 읽어야할 책이다."
        bookIb.genre = "Computer Science"
        bookIb.rating = 9;
        self.list.append(bookIb)
        
        bookIb = BookIbVO();
        bookIb.title = "ROALD DAHL MATILDA"
        bookIb.author = "Quentin Blake"
        bookIb.detail = """
Make sure
EVERYTHING YOU DO IS SO
completely CREAZEBABLE.
"""
        bookIb.genre = "Story"
        bookIb.rating = 8;
        self.list.append(bookIb)
        */
//  }
    
    
    
    //위의 과정을 보면 매번 데이터 정보를 클래스 매개변수 개별 복 붙한 후에 정의하는 방식보다
    // 더 나은 방식을 찾아야한다.
    // 아래와 같은 방식이다.. (대박임)
    /**
     ***Date : 20.02.03**
     *REST API를 받아와 list의 원소를 추가하기 때문에 이제 아래에서 내가 정의한 dataset의 배열이 필요 없어졌다.*
     */
    //var dataset = [
        //("커리어 스킬","존 슨메즈","완벽한 개발자 인생 로드맵","Computer Science",9,"car.jpg"),
        //("Clean Code","로버트 C.마틴","이 책은 더 나은 코드를 만들려고 애쓰는 프로그래머, 소프트웨어 공학도, 프로젝트 관리자, 팀 리더, 시스템 분석가가 반드시 읽어야할 책이다.","Computer Science",9,"clean.jpg"),
        //("ROALD DAHL MATILDA","Quentin Blake",
//"Make sure EVERYTHING YOU DO IS SO completely CREAZEBABLE.","Story",8,"matil.jpg")
    //];
    
    /** 클래스를 배열로하는 list 변수 생성.
     * list는 bookIbVO 타입을 리스트로하는 배열 이고, 초기화를 함수의 리턴으로 초기화를한다.
     * 근데 클로저를 통한 return으로 초기화를 한다.
     * for문을 통해 차례대로 dataset배열안 튜플의 값을 차례대로 대입한 후에 리턴한다.
     * 언제까지? dataset의 배열 끝까지.
     *
     *원래의 배열 초기화는 list = [bookIbVO]()까지해주어야한다. 클래스의 초기화함수까지,,그런데 이 거는 클로저로 초기화!
     */
    lazy var list : [BookIbVO] = {
        var datalist = [BookIbVO]()
        /**
         ***Date : 20.02.03**
         *REST API를 받아와 list의 원소를 추가하기 때문에 위에서 정의한 dataset의 원소들을 for in 구문으로 추가하지 않아도 된다. 아래서 구현할 것이다.
         */
        /*for (title,detail,author,genre,rating, subImg) in self.dataset{
            let book = BookIbVO();
            book.title = title
            book.author = detail
            book.detail = author
            book.genre = genre
            book.rating = rating
            book.subImg = subImg;
            datalist.append(book)
        }*/
        return datalist
    }()
    /**
     *클로저 복습.
     *func 생략. 함수 명 생략.
     *{ 로 시작 ~ }로 끝.
     *원래 함수는 구현부가 { 로 시작하지만 클로저는 이미 클로저 시작 부분에 {를 썻기에 클로저 구현부에는
     *in 키워드를 씀.
     *ex)   {  ( ) -> Void in
     *      print("클로저 실행");
     *    }
     *클로저 표현식 그 자체가 함수이다.
     *클로저 표현식은 대부분 인자값으로 함수를 넘겨 주어야 할 때 사용된다.
     *하지만 직접 실행할 수도 있다.
     *-----------------------------------------------
     *다시. 위와같은 상황에서  맨 마지막에 클로저 끝 부분에 ()를 넣지 않게 된다면
     *왼쪽 프로퍼티는 배열이지만, 오른쪽은 클로저 기능을 실행할 수 있는 함수와 같으므로 ()를 뺀다면 배열에 함수의 기능을 할당한다는 뜻
     *고로 에러다. 배열은 함수가 될 수 없다.
     *따라서 클로저의 끝 { ... }에 } ( )를 달아 주어야 클로저가 실행된 reutrn 값이 배열 프로퍼티에 저장될 것이다.
     */
    
    //테이블 뷰 행 개수 반환.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.list.count;
    }
    
    //아래 주석은 디폴트 설정에 있는 table View Cell에 대한 구현코드입니다.
    /*
        /**
         *테이블 뷰 각 셀 설정*
         *이 메서드가 한번 호출 될 때마다 하나의 행이 만들어 진다.
         *indexPath를 통해 몇 번째 행을 구성햐아 하는지 알 수 있다.
         *이 함수는 화면에 표현해야 할 목록 수 만큼 이 메서드가 반복적으로 호출된다.
         *행 번호를 알고 싶을 때 .row 쓰면된다.
         */
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //리스트에있는 특정 bookIbVO인스턴스  row에 저장!
            let row = self.list[indexPath.row]
        
            // 재사용 큐를 통해 셀 인스턴스 가져옴
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
            //guard나 조건문 붙이지 않고 옵셔널 체인 쓰면 nil이나 옵셔널 이외의 값이 발생하면 그냥 아래   코드 다음코드로 넘어감.
            cell.textLabel?.text = row.title
            
            /**subTitle, rightDetail, leftDetail 모두 detailTextLabel 속성이다.
             *하지만 subTitle만 두 줄로 분리되어 표시된다.
             *지금은 tableView.dequeueReusable(withIdentifier:)메서드를 통해 생성된 특정 셀 인스턴스를 통해.
             *설정된 subtitle의 내용을 표시해주는 코드이다.
             */
            cell.detailTextLabel?.text = row.detail;
            return cell
        }
    
        //사용자가 특정 목록 중에서 특정 행을 선택 했을 때 didSelsectRowAt매개변수를 갖는 tableView가 호출된다.
      
    */
    /*
     custom prototype cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath)->UITableViewCell{
        //위 메서드 호출될때마다 특정 행에 해당하는 데이터 (클래스 타입) 배열을 row 저장.
        let row = self.list[indexpath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!

        /**
         *커스텀 type로 셀 지정시 cell에 속한,  **내가 임의로 추가한 레이블**을 클래스에 저장된 row라고 하는( 위에서  튜플로 구성된 list 배열(타입: BookIbVO 클래스)의 한 클래스(한개의 책 정보) ) 특정 책 정보의 값과 연결시키는 방법
         *1. **레이블**의 인스펙터 탭 ->Tag에서 특정 레이블의 값을 지정한다.
         *2.레이블을 특정 클래스와 연관된 @IBOutlet 변수를 만든다.
         *아래의 상황은 어트리뷰트 인스펙터 탭에서 입력한 태그 속성을 바탕으로, 프로토타입 셀에 추가된 특정 label을 변수화한다.
         *프로토타입 셀에 추가된 특정레이블을 인식하고 소스코드로 읽어오기 위해선 Tag에 부여한 값과,
         * .viewWithTag() 메서드가 필요하다.
         *키야 .viewWithTag()메서드로  이미지, 버튼, 스위치 버튼 등 객체 대부분을 소스코드로 불러올 수 있다.
         *모든 객체를 불러올 수 단 하나의 메서드로 불러오기에 반환타입은 UIView이다.
         *이래서 다운캐스팅을 하는구나..크으 신기하네
         */
        //여기서 태그 대신 @IBOutlet을 사용하고 싶을 때 UITableViewCell을 상속받는 클래스 선언하고,
        //세그웨이 방식으로 연결해서, 위에선언한 cell변수의 기능은 원래 있던 태이블 뷰의 특정 Cell을 인스턴스화 하는 것인데,
        //우리는 UITableViewCell을 상속받고, 자식객체로 정의했으므로 위의 cell 구문 뒤에 as <자식객체> 연산자를 통해 다운 캐스팅을 해야한다.
        let title = cell.viewWithTag(101) as? UILabel;
        let decs = cell.viewWithTag(102) as? UILabel;
        let genre = cell.viewWithTag(103) as? UILabel;
        let rating = cell.viewWithTag(104) as? UILabel;
        let subImg = cell.viewWithTag(105) as? UIImageView;
        title?.text = row.title
        decs?.text = row.detail;
        genre?.text = row.genre;
        rating?.text = "\(row.rating!)";
        subImg?.image = UIImage(named: row.subImg!);
            
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    /**
     *API를 사용한 데이터 호출 방법
     *   Date : 20.02.03
     *
     **to do : 1
     *url 주소 string으로 받은 후
     *URL(string:)을 통해 url 객체를 생성한다.
     *REST API를 호출해서 응답 데이터를 apidata로 받아온다.
     *      이때 Data(contentsOf:)를 통해 REST API가 호출되는데, 호출에 필요한 네트워크 주소는 URL객체가 인자값으로 전달되야 한다.
     *로그 출력.
     *      이때  Data는 우리가 알아볼 수 없는 형태이므로 NSString메서드를 통해 Encoding작업을 한다.
     *
     **to do: 2
     *Data 타입으로 호출된 REST API(JSON)는 확인하기 어렵다. 따라서  NSDictionary형태로 변환 해야 한다.
     *JSONObject포맷의 데이터와 호환되고,
     *리스트 형태의 경우 JSONArray와 호환되는 NSArray로 사용해야한다.
     *일반 문자열의 경우 String으로 사용해야한다.
     *각각 호환되는 스위프트 자료형으로 **형 변환**을 해야 한다.
     *
     *jsonObject()의 경우 오류 발생시 예외를 던지므로 try catch문을 사용해야한다.
     *NSDictionary, NSArray의 형태가 나올 수 있기에, Any타입으로 반환된다.
     *      추후 내가 원하는 객체로 캐스팅해서 사용하자!
     *apiDictionary를 통해 JSON 데이터를 참조할 수 있다.
     *JSON에서 구성된 하위 노드의 정보를 얻기 위해서는 그에 상응하는 키 값을 사용해야 한다.
     */
     override func viewDidLoad() {
         //to do: 1
         let url = "http://115.68.183.178:2029/theater/list"
         let apiURI: URL! = URL(string: url)
         let apidata = try! Data(contentsOf: apiURI)
         let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "";
         NSLog("API Result =\( log )")
            
         //to do: 2
         do{
             //첫번째 인자값: 파싱할 데이터. 두번재 인자값 파싱 옵션(빈 배열 == 아무것도 없다.)
             let apiDicitionary = try JSONSerialization.jsonObject(with: apidata,options: []) as! NSDictionary
             //각각 apiDicitionary로 받은 JSON 데이터에 상응하는 키값을 호출한 후 인스턴스를 얻으면서,
             //하위 데이터까지 참조할 수 있다. 다음은 각각 키값에 따른 하위 데이터를 호출하는 방법이다.
             let hoppin = apiDicitionary["hoppin"] as! NSDictionary;
             let movies = hoppin["movies"] as! NSDictionary;
             let movie = movies["movie"] as! NSArray;
                
             for row in movie {
                 /**
                  *movie는 REST API를 통해 받아온 JSON 데이터의 가장 하위 데이터의 배열이다.
                  *RESt API에 저장된 여러 영화,, movie라는 변수에 저장됬다. 이때 타입은 NSArray. 배열이다.
                  *따라서 row는 그 배열의 첫 원소부터 movie.last까지. 한개씩 받아오는 것인데,
                  *영화의 하위 데이터는  movieID, title, generIds, ratingAverage, participant 등 영화 정보와 관련된 내용이 저장되어있다.
                  *이 중 필요한 부분, 내가 테이블 뷰의 셀에 호출시키기 위한 list에 값이 입력 되어 있어야 한다.
                  *따라서 필요한 정보를 NSDictionary로 변환해, 키값에 맞는 데이터를 해당 list의 특정 mvo라는 인스턴스에 한개의 영화 정보를 저장 후 list.append(mvo)를 통해 정보를 저장한다.
                  */
                 let r = row as! NSDictionary;
                    
                 let mvo = BookIbVO()
                 mvo.title = r["title"] as? String
                 mvo.detail = r["genreNames"] as? String
                 mvo.subImg = r["thumbnailImage"] as? String
                 mvo.detail = r["linkUrl"] as? String
                 mvo.rating = ((r["ratingAverage"] as! NSString).integerValue);
                    
                 self.list.append(mvo)
             }
         }catch { }
         //이상하게 .. Info에서 http에 대한 설정 허가도 했는데, do 구문에서 끊긴다. 그 이전에
         //NSLog도 호출이 되지 않는다..ㅠㅠ
     }
}

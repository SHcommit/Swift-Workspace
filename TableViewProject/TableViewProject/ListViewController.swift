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
    var dataset = [
        ("커리어 스킬","존 슨메즈","완벽한 개발자 인생 로드맵","Computer Science",9),
        ("Clean Code","로버트 C.마틴","이 책은 더 나은 코드를 만들려고 애쓰는 프로그래머, 소프트웨어 공학도, 프로젝트 관리자, 팀 리더, 시스템 분석가가 반드시 읽어야할 책이다.","Computer Science",9),
        ("ROALD DAHL MATILDA","Quentin Blake",
"Make sure EVERYTHING YOU DO IS SO completely CREAZEBABLE.","Story",8)
    ];
    
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
        for (title,detail,author,genre,rating) in self.dataset{
            let book = BookIbVO();
            book.title = title
            book.author = detail
            book.detail = author
            book.genre = genre
            book.rating = rating
            
            datalist.append(book)
        }
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
    
    override func viewDidLoad(){
        print("테이블 뷰 실행됬다면. 출력해줘..")
    }
    
    //테이블 뷰 행 개수 반환.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count;
    }
    /**
     *테이블 뷰 각 셀 설정*
     *이 메서드가 한번 호출 될 때마다 하나의 행이 만들어 진다.
     *indexPath를 통해 몇 번째 행을 구성햐아 하는지 알 수 있다.
     *이 함수는 화면에 표현해야 할 목록 수 만큼 이 메서드가 반복적으로 호출된다.
     *행 번호를 알고 싶을 때 .row 쓰면된다.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        // 재사용 큐를 통해 셀 인스턴스 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        //guard나 조건문 붙이지 않고 옵셔널 체인 쓰면 nil이나 옵셔널 이외의 값이 발생하면 그냥 아래 코드 다음코드로 넘어감.
        cell.textLabel?.text = row.title
        return cell
    }
    
    //사용자가 특정 목록 중에서 특정 행을 선택 했을 때 didSelsectRowAt매개변수를 갖는 tableView가 호출된다.
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    /*
     custom prototype celll
     */
}

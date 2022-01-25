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
}

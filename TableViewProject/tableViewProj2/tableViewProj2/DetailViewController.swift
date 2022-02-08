//
//  DetailViewController.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/07.

import Foundation
import WebKit
class DetailViewController : UIViewController{
    /**
     *WebKit 컨트롤 아울렛 프로퍼티 만들고,
     *화면이 전환될 때 특정 cell의 정보를 전달받을 mvo  프로퍼티를 선언한다.
     *단순히 화면만 바뀌는 게 아니라, 특정 cell의 영화 정보 또한 얻어야 하는데, 클래스의 특정 멤버변수만 받는게 아니라 특정 클래스를 전체로 받는 것을 추천한다.*
     */
    var mvo: MovieVO!
    @IBOutlet var webView: WKWebView!
    /**
     *navigationItem.title으로 Navigation Bar의 타이틀을 접근할 수 있다.
     *URL 인스턴스를 만들고, URLRequest(url:)인스턴스를 생성한다.
     *이 인스턴스는 load( )메서드를 호출한다.
     **WKWebView는 인앱 브라우저를 호출할 수 있다.
     *  1. url인스턴스를 만들고, 이 인스턴스를 사용하여
     *  2.URLRequest 인스턴스를 만든후에,
     *  3.VC에서 아울렛 변수로 연결한 webView객체의 load( ) 메서드를 사용하면
     *  4.인앱 브라우저가 호출된다.
     */
    override func viewDidLoad(){
        NSLog("linkUrl = \(self.mvo.detail!), title = \(self.mvo.title!)");
        let navibar = self.navigationItem
        navibar.title = self.mvo.title;
        
        let url = URL(string:self.mvo.detail!)
        let req = URLRequest(url: url!)
        self.webView.load(req)
    }
}

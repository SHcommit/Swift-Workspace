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
    @IBOutlet var spinner: UIActivityIndicatorView!
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
        
        self.webView.navigationDelegate = self
        
        self.webView.uiDelegate = self
        
        if let url = self.mvo.detail {
            if let urlObj = URL(string: url){
                let req = URLRequest(url: urlObj);
                self.webView.load(req);
            }else{
                let alert = UIAlertController(title: "오류", message: "mvo.detail의 Url이 잘못 되었습니다.", preferredStyle: .alert)
                //UIAlertAction의 세번째 매개변수는 이함수가 작동 됬을때 실행 될 구문이다. (클로저 사용)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel){
                    (_) in
                    //VC뒤로가기
                    _ = self.navigationController?.popViewController(animated: true)
                })
                //alert 또한 하나의 UIViewController이기 때문에 present(_, animated:completion:)메서드를 통해 가려주어야한다.
                self.present(alert, animated: false, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "오류", message: "잘못된 url 피라미터 값입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel){
                (_) in
                _ = self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: false, completion: nil)
        }
        let url = URL(string:self.mvo.detail!)
        let req = URLRequest(url: url!)
        self.webView.load(req)
    }
}
// MARK - WKNavigationDelegate 프로토콜
extension DetailViewController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //인디케이터 뷰 시작
        self.spinner.startAnimating();
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    //에러가났을 경우 경고 메세지 발송!
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        let alert = UIAlertController(title: "오류", message: "로딩 실패했습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel){
            (_) in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        let alert = UIAlertController(title: "", message: "상세 페이지 읽어오지 못했습니다.", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .cancel){
            (_) in
            self.navigationController?.popViewController(animated: true) })
        present(alert, animated: true, completion: nil)
    }
}
// MARK - WKUIDelegate 프로토콜
extension DetailViewController : WKUIDelegate{
    
}

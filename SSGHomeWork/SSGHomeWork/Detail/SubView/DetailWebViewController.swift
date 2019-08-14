//
//  DetailWebViewController.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 15..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
 
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var wkWebView = WKWebView()
    
    var loadUrlString : String  = ""
    
    //MARK:- ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initializeObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Initialize
    
    func initView(){
        self.title = "링크페이지"
        
        activityIndicator.startAnimating()
        
        self.wkWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.wkWebView = WKWebView(frame: self.view.frame)
        self.containerView.addSubview(wkWebView)
      
        //웹킷뷰 크기 조절을 위해 추가
        self.wkWebView.translatesAutoresizingMaskIntoConstraints = false
        self.wkWebView.edges([.left, .right, .top, .bottom], to: self.containerView, offset: .zero)
        self.wkWebView.size(width: self.containerView.frame.width, height: self.containerView.frame.height)
    }
    
    func initializeObject(){
        self.wkWebView.uiDelegate = self
        self.wkWebView.navigationDelegate = self
        let request = URLRequest(url: URL(string: loadUrlString)!)
        DispatchQueue.main.async {
            self.wkWebView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.isHidden = true
    }
}
// 웹킷뷰 위치/사이즈 조정을 위해 필요한 Constraint함수들
extension UIView {
 
    func size(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    
    func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        }
    }
}

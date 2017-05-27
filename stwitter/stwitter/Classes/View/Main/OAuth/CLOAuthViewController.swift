//
//  CLOAuthViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/27.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit
import SVProgressHUD
class CLOAuthViewController: UIViewController {

    fileprivate lazy var webView = UIWebView()
    
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        title = "登录weibo"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", fontSize: 14, target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "自动填充", target: self, action: #selector(autoFill))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(CLAppKey)&redirect_uri=\(CLRedirectURL)"
        guard let url = URL.init(string: urlStr) else {
            return
        }
        let request = URLRequest.init(url: url)
        
        webView.loadRequest(request)
        webView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func close() -> () {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
   
    
    @objc fileprivate func autoFill(){
        
        
        let js = "document.getElementById('userId').value = \(KUsername);" + "document.getElementById('passwd').value = \(KPassword);"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }

}

extension CLOAuthViewController:UIWebViewDelegate{
    
    /// - Parameters:
    ///   - webView: webView
    ///   - request: request description
    ///   - navigationType: navigationType description
    /// - Returns: return value description
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.absoluteString.hasPrefix(CLRedirectURL) == false {
            return true
        }
        print("加载请求----\(String(describing: request.url?.absoluteString))")
        
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            
            return false
        }
        
        let code =  request.url?.query?.substring(from: "code=".endIndex)
        
        print("获取授权ma---\(String(describing: code))")
        CLNetworkManager.shared.loadAccessToken(code: code!)
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

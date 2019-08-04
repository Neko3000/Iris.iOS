//
//  ViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 3/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController{
    
    
    var loginWKWebView:WKWebView?

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loginBtn.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple")!, alpha: 0.3, x: 15, y: 20, blur: 30, spread: 0)

        
        loginWKWebView = WKWebView()
        loginWKWebView!.navigationDelegate = self
        
        loginWKWebView!.frame = view.bounds

        
    }
    
    private func getAccessToken(code:String){
        
        AlamofireManager.sharedSession.request(DeviantArtManager.generateAccessTokenURL(clientId: ApplicationKey.clientKey, clientSecret: ApplicationKey.secretKey, grantType: "authorization_code", code: code, redirectUrl: "https://www.roseandcage.com")).responseJSON(completionHandler: {
            (response) in
            
            switch(response.result){
                
            case .success(let json):
                
                if(response.response?.statusCode == 200){
                    
                    let dict = json as! [String:Any]
                    let accessToken = dict["access_token"] as! String
                    let refreshToken  = dict["refresh_token"] as! String
                                        
                    ActiveUserInfo.setAcesssToken(accessToken: accessToken)
                    ActiveUserInfo.setRefreshToken(refreshToken: refreshToken)
                    
                }
                else if(response.response?.statusCode == 401){
                    
                    let dict = json as! [String:Any]
                    
                    print(dict["error"] as! String)
                }

                break
                
            case .failure(_):
                break
            }
            
            })
        
    }

    @IBAction func loginBtnTouchUpInside(_ sender: Any) {
        view.addSubview(loginWKWebView!)
        
        let request = URLRequest(url: DeviantArtManager.generateAuthorizationCodeURL(responseType: "code", clientId: ApplicationKey.clientKey, redirectUrl: "https://www.roseandcage.com", scope: "basic", state: "bingo"))
        
        loginWKWebView?.load(request)
    }
    
}

extension LoginViewController:UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if(navigationAction.request.url?.host == "www.roseandcage.com"){
            loginWKWebView?.removeFromSuperview()
            
            let code = RequestAnalyzer.getQueryStringParameter(url: (navigationAction.request.url?.absoluteString)!, param: "code")
            getAccessToken(code: code!)
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}


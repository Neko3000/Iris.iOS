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
import NVActivityIndicatorView

class LoginViewController: UIViewController{
    
    var loginWKWebView:WKWebView?

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginActivityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loginBtn.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple")!, alpha: 0.3, x: 15, y: 20, blur: 30, spread: 0)
        loginActivityIndicatorView.type = .ballBeat
        loginActivityIndicatorView.color = UIColor(named: "text-normal-purple")!
        
        loginWKWebView = WKWebView()
        loginWKWebView!.navigationDelegate = self
        loginWKWebView!.frame = view.bounds
        
        initUserState()
    }
    
    private func initUserState(){
        
        if let loadedUserInfo = UserInfo.loadUserInfo(){
            
            self.changeLayoutToLoading()
            
            // check Token
            AlamofireManager.sharedSession.request(DeviantArtManager.generateCheckTokenURL(accessToken: loadedUserInfo.accessToken)).responseJSON(completionHandler: {
                (response) in
                
                switch(response.result){
                    
                case .success(_):
                    
                    if(response.response?.statusCode == 200){
                        
                        ActiveUserInfo.setAcesssToken(accessToken: loadedUserInfo.accessToken)
                        ActiveUserInfo.setRefreshToken(refreshToken: loadedUserInfo.refreshToken)
                        
                        //segue to explore
                        self.performSegue(withIdentifier: "LoginToExplore", sender: nil)
                    }
                    else if(response.response?.statusCode == 401){
                        
                        // refresh token
                        AlamofireManager.sharedSession.request(DeviantArtManager.generateRefreshTokenURL(clientId: ApplicationKey.clientKey, clientSecret: ApplicationKey.secretKey, grantType: "refresh_token", refreshToken: loadedUserInfo.refreshToken)).responseJSON(completionHandler: {
                            (response) in
                            
                            switch(response.result){
                                
                            case .success(let json):
                                
                                if(response.response?.statusCode == 200){
                                    
                                    let dict = json as! [String:Any]
                                    let accessToken = dict["access_token"] as! String
                                    let refreshToken  = dict["refresh_token"] as! String
                                    
                                    ActiveUserInfo.setAcesssToken(accessToken: loadedUserInfo.accessToken)
                                    ActiveUserInfo.setRefreshToken(refreshToken: loadedUserInfo.refreshToken)
                                    
                                    ActiveUserInfo.setAcesssToken(accessToken: accessToken)
                                    ActiveUserInfo.setRefreshToken(refreshToken: refreshToken)
                                    
                                    let userInfo = UserInfo(accessToken: accessToken, refreshToken: refreshToken)
                                    UserInfo.saveUserInfo(userInfoObject: userInfo)
                                    
                                    // segue to explore
                                    self.performSegue(withIdentifier: "LoginToExplore", sender: nil)
                                    
                                }
                                else if(response.response?.statusCode == 401){
                                    
                                    let dict = json as! [String:Any]
                                    
                                    print(dict["error"] as! String)
                                    
                                    // set layout for login
                                    self.changeLayoutToLogin()
                                }
                                else{
                                    self.changeLayoutToLogin()
                                }
                                break
                                
                            case .failure(_):
                                break
                            }
                        })
                    }
                    else{
                        self.changeLayoutToLogin()
                    }
                    break
                    
                case .failure(_):
                    break
                }
                
            })
            
        }
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
                    
                    let userInfo = UserInfo(accessToken: accessToken, refreshToken: refreshToken)
                    UserInfo.saveUserInfo(userInfoObject: userInfo)
                    
                    // segue to explore
                    self.performSegue(withIdentifier: "LoginToExplore", sender: nil)
                }
                else if(response.response?.statusCode == 401){
                    
                    let dict = json as! [String:Any]
                    
                    print(dict["error"] as! String)
                    
                    self.changeLayoutToLogin()
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
    
    func changeLayoutToLoading(){
        loginBtn.alpha = 0
        loginBtn.isUserInteractionEnabled = false
        
        loginActivityIndicatorView.startAnimating()
    }
    func changeLayoutToLogin(){
        loginBtn.alpha = 1.0
        loginBtn.isUserInteractionEnabled = true
        
        loginActivityIndicatorView.stopAnimating()

    }
}

extension LoginViewController:UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if(navigationAction.request.url?.host == "www.roseandcage.com"){
            loginWKWebView?.removeFromSuperview()
            
            changeLayoutToLoading()
            
            let code = RequestAnalyzer.getQueryStringParameter(url: (navigationAction.request.url?.absoluteString)!, param: "code")
            getAccessToken(code: code!)
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}


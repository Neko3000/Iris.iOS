//
//  ViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 3/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameImage.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple")!, alpha: 0.3, x: 15, y: 10, blur: 6, spread: 0)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [.foregroundColor:UIColor(named: "input-normal-purple")!.withAlphaComponent(0.3)])
        
        passwordImage.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple")!, alpha: 0.3, x: 15, y: 10, blur: 6, spread: 0)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [.foregroundColor:UIColor(named: "input-normal-purple")!.withAlphaComponent(0.3)])
        
        loginBtn.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple")!, alpha: 0.3, x: 15, y: 20, blur: 30, spread: 0)

    }

}


//
//  UserCenterHournalsViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterCommentViewController: UIViewController {

    @IBOutlet weak var commentStackView: UIStackView!
    
    @IBOutlet weak var commentStackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentStackViewHeightConstraint.isActive = false
        
        commentStackView.spacing = 10.0
        commentStackView.distribution = .equalSpacing

        let tempView = UserCenterCommentHeaderStackViewSubview()
        let tempView2 = UserCenterCommentHeaderStackViewSubview()
        let tempView3 = UserCenterCommentHeaderStackViewSubview()
        
        let tempView4 = UserCenterCommentReplyStackViewSubview()
        let tempView5 = UserCenterCommentReplyStackViewSubview()
        
        commentStackView.addArrangedSubview(tempView)
        commentStackView.addArrangedSubview(tempView2)
        commentStackView.addArrangedSubview(tempView3)
        
        commentStackView.addArrangedSubview(tempView4)
        commentStackView.addArrangedSubview(tempView5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


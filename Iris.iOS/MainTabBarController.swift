//
//  MainTabBarController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/5/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        tabBar.items![0].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        tabBar.items![1].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        tabBar.items![2].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        tabBar.items![3].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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

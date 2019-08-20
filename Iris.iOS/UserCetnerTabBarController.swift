//
//  MainTabBarController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/5/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCetnerTarBarController: UITabBarController {

    var isTabBarInitialized = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
        
        tabBar.barTintColor = .white
        
        tabBar.items![0].image = UIImage(named: "icon-gallery")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![0].selectedImage = UIImage(named: "icon-gallery-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![0].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBar.items![1].image = UIImage(named: "icon-journal")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![1].selectedImage = UIImage(named: "icon-journal-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![1].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBar.items![2].image = UIImage(named: "icon-calendar")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].selectedImage = UIImage(named: "icon-calendar-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBar.items![3].image = UIImage(named: "icon-favourite")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![3].selectedImage = UIImage(named: "icon-favourite-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![3].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBar.items![4].image = UIImage(named: "icon-follower")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![4].selectedImage = UIImage(named: "icon-follower-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![4].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        tabBar.items![5].image = UIImage(named: "icon-chart")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![5].selectedImage = UIImage(named: "icon-chart-active")!.withRenderingMode(.alwaysOriginal)
        tabBar.items![5].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if(!isTabBarInitialized){
            tabBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 270.0 + 15.0, width: tabBar.frame.size.width, height: 60)
            
            isTabBarInitialized = true
        }

    }
    
    override var traitCollection: UITraitCollection {
        let realTraits = super.traitCollection
        let fakeTraits = UITraitCollection(horizontalSizeClass: .regular)
        return UITraitCollection(traitsFrom: [realTraits, fakeTraits])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToUserCenter"){
            print("Move to User Center")
        }
    }
}

//
//  UserCenterStatusViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterFavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "UserCenterFavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterFavoriteTableViewCell")
        
        favoriteTableView.separatorStyle = .none
        favoriteTableView.allowsSelection =  false
    
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

extension UserCenterFavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterFavoriteTableViewCell") as! UserCenterFavoriteTableViewCell
        
        specificCell.setContentImage(leftContentImage: UIImage(named: "user-center-favorite-ahri-1")!, rightContentImage: UIImage(named: "user-center-favorite-ahri-2")!, fullHeight: 142, fullWidth: tableView.frame.width, gapWidth: 8)
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//
//  DailyViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/14/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController{

    // Outlets
    @IBOutlet weak var dailyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dailyTableView.register(UINib(nibName: "DailyTableViewPostTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewPostTableViewCell")
        dailyTableView.register(UINib(nibName: "DailyTableViewDateTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewDateTableViewCell")
        
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        
        dailyTableView.separatorStyle = .none
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

extension DailyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if(indexPath.row == 0){
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewDateTableViewCell") as! DailyTableViewDateTableViewCell
            
            cell = specificCell
        }
        else{
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewPostTableViewCell") as! DailyTableViewPostTableViewCell
            
            // Setting
            specificCell.setArt(art: UIImage(named: "daily-ahri-1")!)
            specificCell.setTitle(title: "Ahri for iPhone case")
            specificCell.setCommentCount(commentCount: "\(2310)")
            specificCell.setLikeCount(likeCount: "\(10410)")
            specificCell.setAuthorName(authorName: "bibico-Atelier")
            specificCell.setAuthorAvatar(authorAvatar: UIImage(named: "bibico-Atelier")!)
            
            cell = specificCell
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height:CGFloat = 0
        
        if(indexPath.row == 0){
            height = 62
        }
        else{
            height = 340
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
}

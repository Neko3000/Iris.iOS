//
//  ActivityViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
        
    @IBOutlet weak var activityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(UINib(nibName: "ActivityTableViewSubmitCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewSubmitCell")
        activityTableView.register(UINib(nibName: "ActivityTableViewCommentCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCommentCell")
        
        activityTableView.allowsSelection = false        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityTableView.reloadData()
    }
}

extension ActivityViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        var specificCell:UITableViewCell?
        if(indexPath.section % 2 == 0){
            specificCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewSubmitCell") as! ActivityTableViewSubmitCell
        }
        else{
            specificCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCommentCell") as! ActivityTableViewCommentCell            
        }
        cell = specificCell
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat?
        
        if(indexPath.section % 2 == 0){
            height = 100
        }
        else{
            height = 180
        }
        return height!
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
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(cell is ActivityTableViewCommentCell){
            let specificCell = cell as! ActivityTableViewCommentCell
            specificCell.setMask()
        }
    }
}

//
//  UserCenterStatusViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterStatusViewController: UIViewController {
    
    var statuses:[Status] = [Status]()
    var statusForSingleMonthCollection:[StatusForSingleMonth] = [StatusForSingleMonth]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var isFetchStatus:Bool = false

    @IBOutlet weak var statusTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        statusTableView.register(UINib(nibName: "UserCenterStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterStatusTableViewCell")
        
        statusTableView.delegate = self
        statusTableView.dataSource = self
        
        statusTableView.separatorStyle = .none        
        statusTableView.allowsSelection =  false
    
        fetchStatuses()
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

    func fetchStatuses(){
        
        isFetchStatus = true
        
        print(DeviantArtManager.generateGetStatusURL(username: ActiveUserInfo.getUsername(), offset:pageOffset, limit:pageLimit, accessToken: ActiveUserInfo.getAccesssToken()))
        
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetStatusURL(username: ActiveUserInfo.getUsername(), offset:pageOffset, limit:pageLimit, accessToken: ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.statuses = JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)
                        self.statusForSingleMonthCollection = DeviantionHandler.sortStatusByMonth(statuses: self.statuses)
                        
                        self.pageOffset += self.pageLimit
                        self.statusTableView.reloadData()
                        
                        self.fetchAuthorAvatarImage()
                    }
                }
                else if(response.response?.statusCode == 401){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        print(json["error"])
                    }
                }
                
                break
            case .failure(_):
                break
            }
        })
        
    }
    
    func fetchAuthorAvatarImage(){
        
        for i in 0..<statuses.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(statuses[i].authorAvatarSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        let authorAvatarImage = UIImage(data: response.data!)
                        self.statuses[i].authorAvatarImage = authorAvatarImage
                        
                        self.statusTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.isFetchStatus = false
            
        }
    }

}

extension UserCenterStatusViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusForSingleMonthCollection[section].statuses.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return statusForSingleMonthCollection.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = statusForSingleMonthCollection[indexPath.section].statuses[indexPath.row]
        
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterStatusTableViewCell") as! UserCenterStatusTableViewCell
        specificCell.bodyLabel.text = status.body
        specificCell.dateLabel.text = DeviantionHandler.formateDate(date: status.date)
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let statusForSingleMonth = statusForSingleMonthCollection[section]
        
        let tempView = UserCenterStatusHeaderView()
        tempView.monthLabel.text = DeviantionHandler.getMonth(date: statusForSingleMonth.date)
        return tempView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 16
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchStatus){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){
            
            fetchStatuses()
        }
    }
}

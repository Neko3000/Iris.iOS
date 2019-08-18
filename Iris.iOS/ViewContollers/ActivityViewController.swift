//
//  ActivityViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivityViewController: UIViewController {
    
    var deviantArtNotifications:[DeviantArtNotification] = [DeviantArtNotification]()
        
    @IBOutlet weak var activityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(UINib(nibName: "ActivityTableViewNormalCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewNormalCell")
        activityTableView.register(UINib(nibName: "ActivityTableViewCommentCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCommentCell")
        
        activityTableView.separatorStyle = .none
        activityTableView.allowsSelection = false
        
        fetchNotifications()
        
        print(DeviantArtManager.generateGetNotificationURL(cursor:"abcdef",accessToken: ActiveUserInfo.getAccesssToken()))
    }
    
    func fetchNotifications(){
    
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetNotificationURL(accessToken: ActiveUserInfo.getAccesssToken())).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.deviantArtNotifications = JSONObjectHandler.convertToObjectArray(jsonArray: json["items"].arrayValue)
                        
                        self.activityTableView.reloadData()
                        
                        self.fetchUserAvatar()
                        self.fetchBackgroundImage()
                    }
                }
                else if(response.response?.statusCode == 401){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        print(json["error"])
                    }
                }
                
            case .failure(_):
                break
            }
            
        })

    }
    
    func fetchUserAvatar(){
        for i in 0..<deviantArtNotifications.count{
            AlamofireManager.sharedSession.request(deviantArtNotifications[i].userAvatarSrc).response(completionHandler: {
                response in
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        
                        let userAvatarImage = UIImage(data: response.data!)
                        self.deviantArtNotifications[i].userAvatarImage = userAvatarImage
                        
                        self.activityTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
    }
    
    func fetchBackgroundImage(){
        
        for i in 0..<deviantArtNotifications.count{
            
            if(deviantArtNotifications[i].deviationContentSrc != ""){
            AlamofireManager.sharedSession.request(deviantArtNotifications[i].deviationContentSrc).response(completionHandler: {
                response in
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        
                        let contentImage = UIImage(data: response.data!)
                        self.deviantArtNotifications[i].deviationContentImage = contentImage
                        
                        self.activityTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
            }
        }
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
        return deviantArtNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM, hh:mm"
        
        let deviantArtNotification = deviantArtNotifications[indexPath.section]
        
        var cell:UITableViewCell?
        
        if(deviantArtNotification.notificationType == .favourite || deviantArtNotification.notificationType == .replay || deviantArtNotification.notificationType == .watch){
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewNormalCell") as! ActivityTableViewNormalCell
            
            // Set
            specificCell.deviationTitleLabel.text = deviantArtNotification.deviationTitle
            
            specificCell.userAvatarImageView.image = deviantArtNotification.userAvatarImage
            specificCell.usernameLabel.text = deviantArtNotification.username
            
            specificCell.notificationTypeLabel.text = deviantArtNotification.notificationTypeString
            specificCell.dateLabel.text = "in \(dateFormatter.string(from: deviantArtNotification.date))"
            
            specificCell.backgroundImageView.image = deviantArtNotification.deviationContentImage
            
            cell = specificCell
            
        }
        else{
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCommentCell") as! ActivityTableViewCommentCell
            
            // Set
            specificCell.deviationTitleLabel.text = deviantArtNotification.deviationTitle

            specificCell.userAvatarImageView.image = deviantArtNotification.userAvatarImage
            specificCell.usernameLabel.text = deviantArtNotification.username
            
            specificCell.bodyLabel.text = deviantArtNotification.commentBody
            
            specificCell.notificationTypeLabel.text = deviantArtNotification.notificationTypeString
            specificCell.dateLabel.text = "in \(dateFormatter.string(from: deviantArtNotification.date))"
            
            specificCell.backgroundImageView.image = deviantArtNotification.deviationContentImage
            specificCell.dialogTailImageView.image = deviantArtNotification.deviationContentImage
            
            cell = specificCell
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        
        let deviantArtNotification = deviantArtNotifications[indexPath.section]
        
        if(deviantArtNotification.notificationType == .favourite || deviantArtNotification.notificationType == .replay || deviantArtNotification.notificationType == .watch){
            height = 100
        }
        else{
            height = 180
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

//
//  UserCenterFollowerViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterFollowerViewController: UIViewController {
    
    var deviantArtUsers:[DeviantArtUser] = [DeviantArtUser]()
    var deviantArtUsersForSingleRequest:[DeviantArtUser] = [DeviantArtUser]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var isFetchingDeviantArtUsers = false

    @IBOutlet weak var followerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        followerTableView.delegate = self
        followerTableView.dataSource = self
        followerTableView.register(UINib(nibName: "UserCenterFollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterFollowerTableViewCell")
        
        followerTableView.separatorStyle = .none
        followerTableView.allowsSelection =  false
        
        fetchDeviantArtUsers()
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
    
    func fetchDeviantArtUsers(){
        
        isFetchingDeviantArtUsers = true
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetWatcherURL(offset:pageOffset,limit:pageLimit,accessToken: ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.deviantArtUsersForSingleRequest = JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)
                        self.deviantArtUsers.append(contentsOf: self.deviantArtUsersForSingleRequest)
                        
                        self.pageOffset += self.pageLimit
                        self.followerTableView.reloadData()
                        
                        self.fetchUserAvatarImage()
                        self.fetchUserBio()
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
    
    func fetchUserAvatarImage(){
        
        for i in 0..<deviantArtUsersForSingleRequest.count{
            
                dispatchGroup.enter()
                AlamofireManager.sharedSession.request(deviantArtUsersForSingleRequest[i].userAvatarSrc).response(completionHandler: {
                    response in
                    
                    defer{
                        self.dispatchGroup.leave()
                    }
                    
                    switch(response.result){
                    case .success(_):
                        
                        if(response.response?.statusCode == 200){
                            let userAvatarImage = UIImage(data: response.data!)
                            self.deviantArtUsersForSingleRequest[i].userAvatarImage = userAvatarImage
                            
                            self.followerTableView.reloadData()
                        }
                        
                        break
                        
                    case .failure(_):
                        break
                    }
                    
                })
            
        }
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.isFetchingDeviantArtUsers = false
            
        }
    }
    
    func fetchUserBio(){
        
        for i in 0..<deviantArtUsersForSingleRequest.count{
            
            print(DeviantArtManager.generateGetUserProfileURL(username:deviantArtUsersForSingleRequest[i].username,accessToken: ActiveUserInfo.getAccesssToken()))
            
            dispatchGroup.enter()
            AlamofireManager.sharedSession.request(DeviantArtManager.generateGetUserProfileURL(username:deviantArtUsersForSingleRequest[i].username,accessToken: ActiveUserInfo.getAccesssToken())).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
    
                    if(response.response?.statusCode == 200){
                        if let data = response.data{
                            let json = JSON(data)
                            
                            self.deviantArtUsersForSingleRequest[i].bio =  json["bio"].string!
                            
                            self.followerTableView.reloadData()
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
            
        }
        
    }


}

extension UserCenterFollowerViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviantArtUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviantArtUser = deviantArtUsers[indexPath.section]
        
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterFollowerTableViewCell") as! UserCenterFollowerTableViewCell
        specificCell.usernameLabel.text = deviantArtUser.username
        specificCell.descriptionLabel.text = deviantArtUser.bio
        specificCell.avatarImageView.image = deviantArtUser.userAvatarImage
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingDeviantArtUsers){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){
            
            fetchDeviantArtUsers()
        }
    }
}

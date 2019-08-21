//
//  UserCenterHournalsViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterJournalViewController: UIViewController {
    
    var journals:[Deviation] = [Deviation]()
    var journalsForSingleRequest:[Deviation] = [Deviation]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var isFetchingJournals:Bool = false

    @IBOutlet weak var journalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        journalTableView.delegate = self
        journalTableView.dataSource = self
        journalTableView.register(UINib(nibName: "UserCenterJournalTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterJournalTableViewCell")
        
        journalTableView.separatorStyle = .none        
        
        fetchJournals()
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

    func fetchJournals(){
        
        isFetchingJournals = true
        
        print(DeviantArtManager.generateGetJournalURL(username: ActiveUserInfo.getUsername(), offset:pageOffset, limit:pageLimit, accessToken: ActiveUserInfo.getAccesssToken()))
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetJournalURL(username: ActiveUserInfo.getUsername(), offset:pageOffset, limit:pageLimit, accessToken: ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.journalsForSingleRequest = JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)
                        self.journals.append(contentsOf: self.journalsForSingleRequest)
                        
                        self.pageOffset += self.pageLimit
                        self.journalTableView.reloadData()
                        
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
        
        for i in 0..<journalsForSingleRequest.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(journalsForSingleRequest[i].authorAvatarSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        let authorAvatarImage = UIImage(data: response.data!)
                        self.journalsForSingleRequest[i].authorAvatarImage = authorAvatarImage
                        
                        self.journalTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.isFetchingJournals = false
            
        }
    }
}

extension UserCenterJournalViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviation = journals[indexPath.section]
        
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterJournalTableViewCell") as! UserCenterJournalTableViewCell
        specificCell.titleLabel.text = deviation.title
        specificCell.likeCountLabel.text = String(deviation.favouriteCount)
        specificCell.commentCountLabel.text = String(deviation.commentCount)
        specificCell.bodyLabel.text = deviation.excerpt
        specificCell.authorAvatarImageView.image = deviation.authorAvatarImage
        
        cell = specificCell
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
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
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingJournals){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){
            
            fetchJournals()
        }
    }
}

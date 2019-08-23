//
//  UserCenterHournalsViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterCommentViewController: UIViewController {
    
    var deviationComments:[DeviationComment] = [DeviationComment]()
    var deviationsCommentsForSinlgeRequest:[DeviationComment] = [DeviationComment]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 50
    
    var isFetchingComments:Bool = false

    @IBOutlet weak var commentStackView: UIStackView!
    
    @IBOutlet weak var commentStackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentStackViewHeightConstraint.isActive = false
        
        commentStackView.spacing = 10.0
        commentStackView.distribution = .equalSpacing
        
        fetchComments()
        
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

    func fetchComments(){
        
        print(AlamofireManager.sharedSession.request(DeviantArtManager.generateGetProfileCommentURL(username: ActiveUserInfo.getUsername(),offset:pageOffset,limit: pageLimit,accessToken: ActiveUserInfo.getAccesssToken())))
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetProfileCommentURL(username: ActiveUserInfo.getUsername(),offset:pageOffset,limit: pageLimit,accessToken: ActiveUserInfo.getAccesssToken())).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        print("this is a set up" + String(json["thread"].arrayValue.count))
                        
                        self.deviationComments = DeviantionHandler.organizeDeviationComments(deviationComments:                         JSONObjectHandler.convertToObjectArray(jsonArray: json["thread"].arrayValue))
                        
                        self.fetchUserAvatarImageForComments()
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
    
    func fetchUserAvatarImageForComments(){
        
        for i in 0..<deviationComments.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(deviationComments[i].userAvatarSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        let userAvatarImage = UIImage(data: response.data!)
                        self.deviationComments[i].userAvatarImage = userAvatarImage
                        
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
            
            for j in 0..<deviationComments[i].subDeviationComments!.count{
                
                dispatchGroup.enter()
                AlamofireManager.sharedSession.request(deviationComments[i].subDeviationComments![j].userAvatarSrc).response(completionHandler: {
                    response in
                    
                    defer{
                        self.dispatchGroup.leave()
                    }
                    
                    switch(response.result){
                    case .success(_):
                        if(response.response?.statusCode == 200){
                            let userAvatarImage = UIImage(data: response.data!)
                            self.deviationComments[i].subDeviationComments![j].userAvatarImage = userAvatarImage
                            
                        }
                        
                        break
                        
                    case .failure(_):
                        break
                    }
                    
                })
                
            }
        }
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.isFetchingComments = false
            
            self.setStackView()
        }
        
    }
    
    
    func setStackView(){
        
        for i in 0..<commentStackView.arrangedSubviews.count{
            commentStackView.arrangedSubviews[i].removeFromSuperview()
        }
        
        for i in 0..<deviationComments.count{
            
            let deivationCommentHeader = deviationComments[i]
            
            let stackViewHeaderView = UserCenterCommentHeaderStackViewSubview()
            commentStackView.addArrangedSubview(stackViewHeaderView)
            
            stackViewHeaderView.authorAvatarImageView.image = deivationCommentHeader.userAvatarImage
            stackViewHeaderView.authorNameLabel.text = deivationCommentHeader.username
            stackViewHeaderView.bodyLabel.text = deivationCommentHeader.body
            stackViewHeaderView.dateLabel.text = DeviantionHandler.formateDate(date: deivationCommentHeader.date)

            
            for j in 0..<deviationComments[i].subDeviationComments!.count{
                
                let deviationCommentReply = deviationComments[i].subDeviationComments![j]
                
                let stackViewReplyView = UserCenterCommentReplyStackViewSubview()
                commentStackView.addArrangedSubview(stackViewReplyView)
                
                stackViewReplyView.bodyLabel.text = deviationCommentReply.body
                stackViewReplyView.authorNameDateLabel.text = "by \(deviationCommentReply.username),\(DeviantionHandler.formateDate(date:deviationCommentReply.date))"
                stackViewReplyView.authorAvatarImageView.image = deviationCommentReply.userAvatarImage

            }
        }
    }
}


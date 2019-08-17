//
//  ArtDetailViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/26/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class ArtDetailViewController: UIViewController {
    
    var deviantionContentImage:UIImage = UIImage()
    
    // From prepare of segue
    var deviantionId:String = ""
    var deviantionContentSrc:String = ""
    var deviantionTitle:String = ""
    var deviantionCategoryPath:String = ""
    var authorName:String = ""
    var authorAvatarSrc:String = ""
    
    var deviationComments:[DeviationComment] = [DeviationComment]()
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var artImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var artTitleLabel: UILabel!
    @IBOutlet weak var artCategoryLabel: UILabel!
    @IBOutlet weak var artDescriptionLabel: UILabel!
    
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var artDetailTableView: UITableView!
    @IBOutlet weak var artDetailTableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        artDetailTableView.delegate = self
        artDetailTableView.dataSource = self
        artDetailTableView.register(UINib(nibName: "ArtDetailTableViewCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtDetailTableViewCommentTableViewCell")
        artDetailTableView.register(UINib(nibName: "ArtDetailTableViewSubCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtDetailTableViewSubCommentTableViewCell")
        
        artDetailTableView.allowsSelection = false
        artDetailTableView.separatorStyle = .none
        
        artDetailTableView.rowHeight = UITableView.automaticDimension
        artDetailTableView.estimatedRowHeight = 140 // set your estimatedHeight
        
        authorAvatarImageView.layer.cornerRadius = 15.0
        authorAvatarImageView.layer.masksToBounds = true
        
        artTitleLabel.text = deviantionTitle
        artCategoryLabel.text = DeviantionHandler.formatCategoryPath(categoryPath: deviantionCategoryPath)
        authorNameLabel.text = authorName
        
        fetchArt()
        fetchAuthorAvatar()
        fetchDescription()
        fetchComments()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // artDetailTableViewHeightConstraint.constant = artDetailTableView.contentSize.height
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchArt(){
    
        // Content image
        AlamofireManager.sharedSession.request(deviantionContentSrc).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    self.deviantionContentImage = UIImage(data: response.data!)!
                    self.artImageView.image = self.deviantionContentImage
                    
                    self.setArtImageViewSize()
                }
                
                break
                
            case .failure(_):
                break
            }
            
        })
        
    }
    
    func fetchAuthorAvatar(){
        AlamofireManager.sharedSession.request(authorAvatarSrc).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    self.authorAvatarImageView.image = UIImage(data: response.data!)!
                }
                
                break
                
            case .failure(_):
                break
            }
            
        })
    }
    
    func fetchDescription(){
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetArtMetaDataURL(deviationIds: deviantionId, accessToken:ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.artDescriptionLabel.text = json["metadata"][0]["description"].string!
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
    
    func fetchComments(){
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetArtCommentURL(deviationId: deviantionId, offset: 0, limit: 50, accessToken: ActiveUserInfo.getAccesssToken())).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.deviationComments = DeviantionHandler.organizeDeviationComments(deviationComments:                         JSONObjectHandler.convertToObjectArray(jsonArray: json["thread"].array!))
                        self.artDetailTableView.reloadData()
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
    
    func setArtImageViewSize(){
        let image = deviantionContentImage
        
        let boundingRect = CGRect(x: 0, y: 0, width: artImageView.frame.width, height: artImageView.frame.height)
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        
        artImageViewHeightConstraint.constant = rect.height
    }


    @IBAction func likeBtnTouchUpInside(_ sender: Any) {
        print("like btn touched!")
    }
    @IBAction func downloadBtnTouchUpInside(_ sender: Any) {
        print("download btn touched!")
    }
    @IBAction func backBtnTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ArtDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviationComments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviationComments[section].subDeviationComment!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviationComment = deviationComments[indexPath.item]
        
        var cell:UITableViewCell?
        
        if(indexPath.row == 0){
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "ArtDetailTableViewCommentTableViewCell") as! ArtDetailTableViewCommentTableViewCell
            
            specificCell.usernameLabel.text = deviationComment.username
            
            specificCell.bodyLabel.text = deviationComment.body
            specificCell.postDateLabel.text = DeviantionHandler.formateDate(date: deviationComment.date)
            
            cell = specificCell
        }
        else{
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "ArtDetailTableViewSubCommentTableViewCell") as! ArtDetailTableViewSubCommentTableViewCell
            
            specificCell.usernameLabel.text = deviationComment.username
            specificCell.bodyLabel.text = deviationComment.body
            
            cell = specificCell
        }
        
        return cell!
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height:CGFloat?
//
//        if(indexPath.ro % 2 == 0){
//            height = 100
//        }
//        else{
//            height = 180
//        }
//        return height!
//    }
    
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
        
        return 48
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(cell is ActivityTableViewCommentCell){
            let specificCell = cell as! ActivityTableViewCommentCell
            specificCell.setMask()
        }
    }
}

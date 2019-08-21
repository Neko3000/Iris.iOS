//
//  UserCenterGalleryViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterGalleryViewController: UIViewController {
    
    var gallery:[Deviation] = [Deviation]()
    var galleryForSingleRequest:[Deviation] = [Deviation]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var isFetchingGallery:Bool = false

    @IBOutlet weak var galleryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        galleryTableView.delegate = self
        galleryTableView.dataSource = self
        galleryTableView.register(UINib(nibName: "UserCenterGalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterGalleryTableViewCell")
        
        galleryTableView.separatorStyle = .none
        
        fetchGallery()
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

    func fetchGallery(){
        
        isFetchingGallery = true
        
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetGalleryURL(offset:pageOffset,limit:pageLimit,accessToken: ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.galleryForSingleRequest = DeviantionHandler.filterJournalDeviation(deviants: JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue))
                        self.gallery.append(contentsOf: self.galleryForSingleRequest)
                        
                        self.pageOffset += self.pageLimit
                        self.galleryTableView.reloadData()
                        
                        self.fetchPreviewImageList()
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
    
    func fetchPreviewImageList(){
        
        for i in 0..<galleryForSingleRequest.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(galleryForSingleRequest[i].previewSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        let previewImage = UIImage(data: response.data!)
                        self.galleryForSingleRequest[i].previewImage = previewImage
                        
                        self.galleryTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.isFetchingGallery = false
            
        }
    }

}

extension UserCenterGalleryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return gallery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviation = gallery[indexPath.section]
        
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterGalleryTableViewCell") as! UserCenterGalleryTableViewCell
        
        specificCell.artImageView.image = deviation.previewImage
        specificCell.titleLabel.text = deviation.title
        specificCell.categoryLabel.text = DeviantionHandler.formatCategoryPath(categoryPath: deviation.categoryPath)
        specificCell.likeCountLabel.text = String(deviation.favouriteCount)
        specificCell.commentCountLabel.text = String(deviation.commentCount)
        
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
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingGallery){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){
            
            fetchGallery()
        }
    }
}

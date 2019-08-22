//
//  UserCenterStatusViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserCenterFavoriteViewController: UIViewController {
    
    var deviationCollectionFolders:[DeviationCollectionFolder] = [DeviationCollectionFolder]()
    var deviationCollectionFoldersForSingleRequest:[DeviationCollectionFolder] = [DeviationCollectionFolder]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var isFetchDeviationCollectionFolders = false
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "UserCenterFavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterFavoriteTableViewCell")
        
        favoriteTableView.separatorStyle = .none
        favoriteTableView.allowsSelection =  false
        
        fetchDeivationCollectionFolder()
    
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

    func fetchDeivationCollectionFolder(){
        
        isFetchDeviationCollectionFolders = true
        
        print(DeviantArtManager.generateGetCollectionFolderURL(offset:pageOffset,limit:pageLimit,accessToken: ActiveUserInfo.getAccesssToken()))
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetCollectionFolderURL(offset:pageOffset,limit:pageLimit,accessToken: ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.deviationCollectionFoldersForSingleRequest = JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)
                        self.deviationCollectionFolders.append(contentsOf: self.deviationCollectionFoldersForSingleRequest)
                        
                        self.pageOffset += self.pageLimit
                        self.favoriteTableView.reloadData()
                        
                        self.fetchPreviewImage()
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
    
    func fetchPreviewImage(){
        
        for i in 0..<deviationCollectionFoldersForSingleRequest.count{
            
            for j in 0..<deviationCollectionFoldersForSingleRequest[i].deviations.count{
                
                dispatchGroup.enter()
                AlamofireManager.sharedSession.request(deviationCollectionFoldersForSingleRequest[i].deviations[j].previewSrc).response(completionHandler: {
                    response in
                    
                    defer{
                        self.dispatchGroup.leave()
                    }
                    
                    switch(response.result){
                    case .success(_):
                        if(response.response?.statusCode == 200){
                            let previewImage = UIImage(data: response.data!)
                            self.deviationCollectionFoldersForSingleRequest[i].deviations[j].previewImage = previewImage
                            
                            self.favoriteTableView.reloadData()
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
            self.isFetchDeviationCollectionFolders = false
            
        }
    }


}

extension UserCenterFavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int((deviationCollectionFolders[section].deviations.count - 1) / 2) + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviationCollectionFolders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deviationCollectionFolder = deviationCollectionFolders[indexPath.section]
        let index = indexPath.row * 2
        
        var cell:UITableViewCell?
        
        let leftContentImage = deviationCollectionFolder.deviations[index].previewImage
        
        let rightContentImage = (index + 1) > deviationCollectionFolder.deviations.count - 1 ? nil:deviationCollectionFolder.deviations[index + 1].previewImage
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "UserCenterFavoriteTableViewCell") as! UserCenterFavoriteTableViewCell
        
        specificCell.setContentImage(leftContentImage: leftContentImage, rightContentImage: rightContentImage, fullHeight: 142, fullWidth: tableView.frame.width, gapWidth: 8)
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let deviationCollectionFolder = deviationCollectionFolders[section]

        let tempView = UserCenterFavoriteHeaderView()
        tempView.folderNameLabel.text = deviationCollectionFolder.name

        return tempView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
}

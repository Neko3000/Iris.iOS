//
//  DailyViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/14/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import SwiftyJSON

class DailyViewController: UIViewController{

    var dailyDeviations:[DailyDeviation] = [DailyDeviation]()
    var dailyDeviationsForSingleRequest:DailyDeviation = DailyDeviation()
    
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var currentDate:Date = Date()
    
    var isFetchingDailyDeviations = true
    
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
        
        fetchDailyDeviations()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchDailyDeviations(){
        
        self.isFetchingDailyDeviations = true
        
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetDailyDeviationURL(date: getDateString(date: currentDate), accessToken: ActiveUserInfo.getAccesssToken())).response(completionHandler: {
            response in
            
            switch(response.result){
            case .success(_):
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.dailyDeviationsForSingleRequest = DailyDeviation(date: self.currentDate, deviations: DeviantionHandler.filterJournalDeviation(deviants: JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)))
                        self.dailyDeviations.append(self.dailyDeviationsForSingleRequest)
                        
                        self.dailyTableView.reloadData()
                        
                        self.fetchPreviewImage()
                        self.fetchAuthorAvatar()
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
    
    func fetchPreviewImage(){
        
        for i in 0..<dailyDeviationsForSingleRequest.deviations.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(dailyDeviationsForSingleRequest.deviations[i].previewSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        
                        let previewImage = UIImage(data: response.data!)
                        self.dailyDeviationsForSingleRequest.deviations[i].previewImage = previewImage
                        
                        self.dailyTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
        
        // DispatchGroup
        // NOTE!: It can't be put on ViewDidLoad, maybe should make it enter() at least one time before this code block
        dispatchGroup.notify(queue: .main){
            
            self.isFetchingDailyDeviations = false
        }

    }

    
    func fetchAuthorAvatar(){
        
        for i in 0..<dailyDeviationsForSingleRequest.deviations.count{
            
            dispatchGroup.enter()
            AlamofireManager.sharedSession.request(dailyDeviationsForSingleRequest.deviations[i].authorAvatarSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                case .success(_):
                    if(response.response?.statusCode == 200){
                        
                        let authorAvatarImage = UIImage(data: response.data!)
                        self.dailyDeviationsForSingleRequest.deviations[i].authorAvatarImage = authorAvatarImage
                        
                        self.dailyTableView.reloadData()
                    }
                    
                    break
                    
                case .failure(_):
                    break
                }
                
            })
        }
    }
    
    func getDateString(date:Date)->String{
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
}

extension DailyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyDeviations[section].deviations.count + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyDeviations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if(indexPath.row == 0){
            let dailyDeviation = dailyDeviations[indexPath.section]
            
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewDateTableViewCell") as! DailyTableViewDateTableViewCell
            
            specificCell.dateLabel.text = DeviantionHandler.formateDate(date: dailyDeviation.date)
            
            cell = specificCell
        }
        else{
            let deviation = dailyDeviations[indexPath.section].deviations[indexPath.row - 1]
            
            let specificCell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewPostTableViewCell") as! DailyTableViewPostTableViewCell
            
            specificCell.artImageView.image = deviation.previewImage
            specificCell.titleLabel.text = deviation.title
            specificCell.commentCountLabel.text = String(deviation.commentCount)
            specificCell.likeCountLabel.text = String(deviation.favouriteCount)
            specificCell.authorNameLabel.text = deviation.authorName
            specificCell.authorAvatarImageView.image = deviation.authorAvatarImage
            
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
        
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingDailyDeviations){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){
            
            fetchDailyDeviations()
        }
    }
}

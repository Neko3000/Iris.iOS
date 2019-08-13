//
//  ArtListViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/18/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit
import AVFoundation
import TwicketSegmentedControl
import SwiftyJSON
import NVActivityIndicatorView

class ArtListViewController: UIViewController{
    
    var searchKeyword:String = ""
    
    var posts:[UIImage] = [UIImage]()
    var categories:[String] = [String]()
    
    var pageOffset:Int = 0
    var pageLimit:Int = 20
    var artList:[Deviation] = [Deviation]()
    var artPreviewImageList:[UIImage] = [UIImage]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var artListForSingleRequest:[Deviation] = [Deviation]()
    var artPreviewImageListForSingleRequest:[UIImage] = [UIImage]()
    
    var isFetchingArtList = false

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categorySelectorTwicketSegmentedControl: TwicketSegmentedControl!
    @IBOutlet weak var artListCollectionView: UICollectionView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var categorySelectorTableView: UITableView!
    @IBOutlet weak var activityIndicatorViewCenter: NVActivityIndicatorView!
    
    var activityIndicatorViewBottom:NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        posts.append(UIImage(named: "art-list-ahri-1")!)
        posts.append(UIImage(named: "art-list-ahri-2")!)
        posts.append(UIImage(named: "art-list-ahri-3")!)
        posts.append(UIImage(named: "art-list-ahri-4")!)
        posts.append(UIImage(named: "art-list-ahri-5")!)
        posts.append(UIImage(named: "art-list-ahri-6")!)
        
        if let path = Bundle.main.path(forResource: "art-categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{
                    let categoriesNodes = jsonResult["categories"] as! [[String:Any]]
                    for node in categoriesNodes{
                        categories.append(node["title"] as! String)
                    }
                }
            } catch {
                // handle error
            }
            
        }
        
        searchTextField.layer.cornerRadius = 10.0
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.height))
        searchTextField.leftView = leftPadding
        searchTextField.leftViewMode = .always
        
        toolbarView.backgroundColor = UIColor.white.withAlphaComponent(0.98)
        
        let titles = ["Popular", "New", "Undiscovered"]
        categorySelectorTwicketSegmentedControl.setSegmentItems(titles)
        categorySelectorTwicketSegmentedControl.defaultTextColor = UIColor(named: "text-normal-grey")!
        categorySelectorTwicketSegmentedControl.backgroundColor = .clear
        categorySelectorTwicketSegmentedControl.containerViewBackgroundColor = .clear
        categorySelectorTwicketSegmentedControl.segmentsBackgroundColor = .clear
        categorySelectorTwicketSegmentedControl.sliderBackgroundColor = UIColor(named: "background-normal-blue")!
        categorySelectorTwicketSegmentedControl.isSliderShadowHidden = false
        
        artListCollectionView.delegate = self
        artListCollectionView.dataSource = self
        artListCollectionView.contentInset = UIEdgeInsets(top: 82, left: 10.0, bottom: 0, right: 10.0)
        artListCollectionView.register(UINib(nibName: "ArtListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArtListCollectionViewCell")

        //artListCollectionView.refreshControl = refreshControl
        //refreshControl.addTarget(self, action: #selector(loadMoreArt(sender:)), for: .valueChanged)
        
        let collectionViewMasonryViewLayout = CollectionViewMasonryLayout()
        collectionViewMasonryViewLayout.delegate = self
        artListCollectionView.collectionViewLayout = collectionViewMasonryViewLayout
        
        categorySelectorTableView.delegate = self
        categorySelectorTableView.dataSource = self
        categorySelectorTableView.register(UINib(nibName: "CategorySelectorTableViewCell", bundle: nil), forCellReuseIdentifier: "CategorySelectorTableViewCell")
        
        categorySelectorTableView.layer.cornerRadius = 10
        categorySelectorTableView.layer.masksToBounds = true
        categorySelectorTableView.separatorStyle = .none
        categorySelectorTableView.allowsMultipleSelection = false
        categorySelectorTableView.removeFromSuperview() // temp
        
        activityIndicatorViewCenter.type = .orbit
        activityIndicatorViewCenter.color = UIColor(named: "text-normal-purple")!
        
        activityIndicatorViewBottom = NVActivityIndicatorView(frame: CGRect())
        activityIndicatorViewBottom!.type = .orbit
        activityIndicatorViewBottom!.color = UIColor(named: "text-normal-purple")!
        
        fetchArtList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchArtList(){
        activityIndicatorViewCenter.startAnimating()
        
        AlamofireManager.sharedSession.request(DeviantArtManager.generateGetArtListURL(categoryPath: "", q: searchKeyword, timeRange: "",offset: pageOffset, limit: pageLimit, accessToken:ActiveUserInfo.getAccesssToken())).responseJSON(completionHandler: {
            response in

            print(DeviantArtManager.generateGetArtListURL(categoryPath: "", q: self.searchKeyword, timeRange: "", limit: 10, accessToken:ActiveUserInfo.getAccesssToken()))
            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.artListForSingleRequest = JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue)
                        self.fetchPreviewImageList()
                    }
                }
                else if(response.response?.statusCode == 401){
                    
                }
                
                break
            case .failure(_):
                break
            }
        })
    }
    
    func fetchPreviewImageList(){
        
        for i in 0..<artListForSingleRequest.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(artListForSingleRequest[i].previewSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                    case .success(_):
                        let previewImage = UIImage(data: response.data!)
                        self.artPreviewImageListForSingleRequest.insert(previewImage!, at: i)
                        
                        break
                    
                    case .failure(_):
                        break
                }

            })
        }
        
        dispatchGroup.notify(queue: .main){
            self.artList.append(contentsOf: self.artListForSingleRequest)
            self.artPreviewImageList.append(contentsOf: self.artPreviewImageListForSingleRequest)
            self.pageOffset += 1
            
            self.artListCollectionView.reloadData(){
                self.activityIndicatorViewBottom!.frame = CGRect(x: (self.artListCollectionView.contentSize.width - 50)/2.0, y: self.artListCollectionView.contentSize.height, width: 50, height: 50)
        
                self.activityIndicatorViewBottom!.alpha = 0
                self.activityIndicatorViewBottom!.startAnimating()
                
                self.artListCollectionView.addSubview(self.activityIndicatorViewBottom!)
            }
            self.activityIndicatorViewCenter.stopAnimating()
            
        }
    }
    
    func addActivityIndicatorViewBottom(){
        activityIndicatorViewBottom!.frame = CGRect(x: (self.artListCollectionView.contentSize.width - 50)/2.0, y: self.artListCollectionView.contentSize.height, width: 50, height: 50)
        
        activityIndicatorViewBottom!.alpha = 1
        activityIndicatorViewBottom!.startAnimating()
        
        artListCollectionView.addSubview(self.activityIndicatorViewBottom!)
    }
    
    func removeActivityIndicatorViewBottom(){
        activityIndicatorViewBottom!.stopAnimating()
        activityIndicatorViewBottom!.removeFromSuperview()
    }
}

// UICollectionView
extension ArtListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell?
        
        let specificCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtListCollectionViewCell", for: indexPath) as! ArtListCollectionViewCell
        
        specificCell.setArt(art: artPreviewImageList[indexPath.item])
        specificCell.setAuthorName(authorName: "- author\(indexPath.item)")
        
        cell = specificCell
        
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingArtList){
            return
        }
        
        if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.height)){
            let differ = scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.height)
            let percentage = differ / 180 > 1.0 ? 1.0 : differ/180.0
            
            activityIndicatorViewBottom?.alpha = 1.0 * percentage
            
            if(percentage > 0.70){
                
                
                
            }
            print(scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.height))
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // if this scrolling make the percentage > 0.7 even once, trigger fetch
    }
}

// UICollectionView - Delegate
extension ArtListViewController:CollectionViewMasonryLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        let image = artPreviewImageList[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        
        print("\(indexPath.item): \(image.size.width) - \(image.size.height)")
        
        return rect.size.height + 29
    }
    
}

// UITableView
extension ArtListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectorTableViewCell") as! CategorySelectorTableViewCell
        
        specificCell.setCategoryNameLabel(categoryName: categories[indexPath.item])
        specificCell.setStateImageView(isSelected: false)
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
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
        
        return 10
    }
}

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
    var currentOrder:ArtListOrderEnum = .popular
    
    var deviationCategories:[DeviationCategory] = [DeviationCategory]()
    var currentCategory:String = ""
    
    var pageOffset:Int = 0
    var pageLimit:Int = 24
    
    var artList:[Deviation] = [Deviation]()
    var artListForSingleRequest:[Deviation] = [Deviation]()
    let dispatchGroup:DispatchGroup = DispatchGroup()
    
    var isFirstFetch = true
    var isFetchingArtList = true
    
    var isShowingCategorySelectorTableView = false

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var orderSelectorTwicketSegmentedControl: TwicketSegmentedControl!
    @IBOutlet weak var artListCollectionView: UICollectionView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var categorySelectorTableView: UITableView!
    @IBOutlet weak var activityIndicatorViewCenter: NVActivityIndicatorView!
    
    @IBOutlet weak var categorySelectorCenterYAlignmentConstraint: NSLayoutConstraint!
    
    var activityIndicatorViewBottom:NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "art-categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{
                    let categoryNodes = jsonResult["categories"] as! [[String:Any]]
                    for node in categoryNodes{
                        deviationCategories.append(DeviationCategory(categoryName: node["title"] as! String, categoryPath: node["catpath"] as! String))
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
        
        searchTextField.returnKeyType = .go
        searchTextField.delegate = self
        
        searchTextField.text = searchKeyword
        
        toolbarView.backgroundColor = UIColor.white.withAlphaComponent(0.98)
        
        let titles = ["Popular", "New", "Undiscovered"]
        orderSelectorTwicketSegmentedControl.setSegmentItems(titles)
        orderSelectorTwicketSegmentedControl.defaultTextColor = UIColor(named: "text-normal-grey")!
        orderSelectorTwicketSegmentedControl.backgroundColor = .clear
        orderSelectorTwicketSegmentedControl.containerViewBackgroundColor = .clear
        orderSelectorTwicketSegmentedControl.segmentsBackgroundColor = .clear
        orderSelectorTwicketSegmentedControl.sliderBackgroundColor = UIColor(named: "background-normal-blue")!
        orderSelectorTwicketSegmentedControl.isSliderShadowHidden = false
        orderSelectorTwicketSegmentedControl.delegate = self
        
        artListCollectionView.delegate = self
        artListCollectionView.dataSource = self
        artListCollectionView.contentInset = UIEdgeInsets(top: 82, left: 10.0, bottom: 50, right: 10.0)
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
        categorySelectorCenterYAlignmentConstraint.constant = -(UIScreen.main.bounds.height + categorySelectorTableView.frame.height)/2 - 100
        categorySelectorTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        
        activityIndicatorViewCenter.type = .orbit
        activityIndicatorViewCenter.color = UIColor(named: "text-normal-purple")!
        
        activityIndicatorViewBottom = NVActivityIndicatorView(frame: CGRect())
        activityIndicatorViewBottom!.type = .orbit
        activityIndicatorViewBottom!.color = UIColor(named: "text-normal-purple")!
        
        // DispatchGroup
        dispatchGroup.notify(queue: .main){
            self.artList.append(contentsOf: self.artListForSingleRequest)
            self.pageOffset += self.pageLimit
            
            self.artListCollectionView.reloadData(){
                if(self.isFirstFetch){
                    self.activityIndicatorViewCenter.stopAnimating()
                    self.isFirstFetch = false
                }
                else{
                    self.addActivityIndicatorViewBottom()
                }
                
                self.isFetchingArtList = false
                
            }
        }
        
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
        
        // Set state
        isFetchingArtList = true
        
        // Set Activity Indicator
        if(isFirstFetch){
            activityIndicatorViewCenter.startAnimating()
        }
        else{
            addActivityIndicatorViewBottom()
        }
        
        // Set URL
        var searchURL:URL?
        
        switch currentOrder {
        case .popular:
            searchURL = DeviantArtManager.generateGetPopularArtListURL(categoryPath: currentCategory, q: searchKeyword, timeRange: "alltime",offset: pageOffset, limit: pageLimit, accessToken:ActiveUserInfo.getAccesssToken())
            break
        case .new:
            searchURL = DeviantArtManager.generateGetNewestArtListURL(categoryPath: currentCategory, q: searchKeyword,offset: pageOffset, limit: pageLimit, accessToken:ActiveUserInfo.getAccesssToken())
            break
        case .undiscovered:
            searchURL = DeviantArtManager.generateGetUndiscoveredArtListURL(categoryPath: currentCategory, offset: pageOffset, limit: pageLimit, accessToken:ActiveUserInfo.getAccesssToken())
            break
        }
        
        //
        AlamofireManager.sharedSession.request(searchURL!).responseJSON(completionHandler: {
            response in

            switch(response.result){
            case .success(_):
                
                if(response.response?.statusCode == 200){
                    if let data = response.data{
                        let json = JSON(data)
                        
                        self.artListForSingleRequest = DeviantionHandler.filterJournalDeviation(deviants: JSONObjectHandler.convertToObjectArray(jsonArray: json["results"].arrayValue))
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
        
        for i in 0..<artListForSingleRequest.count{
            
            dispatchGroup.enter()
            
            AlamofireManager.sharedSession.request(artListForSingleRequest[i].previewSrc).response(completionHandler: {
                response in
                
                defer{
                    self.dispatchGroup.leave()
                }
                
                switch(response.result){
                    case .success(_):
                        if(response.response?.statusCode == 200){
                            let previewImage = UIImage(data: response.data!)
                            self.artListForSingleRequest[i].previewImage = previewImage
                        }

                        break
                    
                    case .failure(_):
                        break
                }

            })
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
    
    func clearSearch(){
        
        pageOffset = 0
        artList.removeAll()
        artListForSingleRequest.removeAll()
        
        let layout = artListCollectionView.collectionViewLayout as! CollectionViewMasonryLayout
        layout.resetLayout()
        artListCollectionView.reloadData()
        
        isFirstFetch = true
        isFetchingArtList = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ArtListToArtDetail"){
            let destVC = segue.destination as! ArtDetailViewController
            
            let deviantion = sender as! Deviation
            destVC.deviantionId = deviantion.deviationId
            destVC.deviantionContentSrc = deviantion.contentSrc
            destVC.deviantionTitle = deviantion.title
            destVC.deviantionCategoryPath = deviantion.categoryPath
            destVC.authorName = deviantion.authorName
            destVC.authorAvatarSrc = deviantion.authorAvatarSrc
        }
    }
    
    
    @IBAction func cateogryBtnTouchUpInside(_ sender: Any) {
        
        if(isShowingCategorySelectorTableView){
            self.categorySelectorCenterYAlignmentConstraint.constant = -(UIScreen.main.bounds.height + self.categorySelectorTableView.frame.height)/2 - 100
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                
            }, completion: {(isFinished) in
                self.isShowingCategorySelectorTableView = false
            })
        }
        else{
            self.categorySelectorCenterYAlignmentConstraint.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                
            }, completion: {(isFinished) in
                self.isShowingCategorySelectorTableView = true
            })
        }

    }
    @IBAction func backBtnTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ArtListViewController:TwicketSegmentedControlDelegate{
    func didSelect(_ segmentIndex: Int) {
        
        currentOrder = ArtListOrderEnum(rawValue: segmentIndex)!
        
        clearSearch()
        searchKeyword = searchTextField.text!
        fetchArtList()
    }
}

extension ArtListViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == .go){
            
            if(textField.text != nil){
                
                clearSearch()
                searchKeyword = textField.text!
                fetchArtList()
            }
        }
        
        return true
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
        
        specificCell.setArt(art: artList[indexPath.item].previewImage!)
        specificCell.setAuthorName(authorName: "- \(artList[indexPath.item].authorName)")
        
        cell = specificCell
        
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isFetchingArtList){
            return
        }
        
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)){

            fetchArtList()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // When your pull operation ends
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ArtListToArtDetail", sender: artList[indexPath.item])
    }
}

// UICollectionView - Delegate
extension ArtListViewController:CollectionViewMasonryLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        let image = artList[indexPath.item].previewImage!
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
                
        return rect.size.height + 29
    }
    
}

// UITableView
extension ArtListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviationCategories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        let specificCell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectorTableViewCell") as! CategorySelectorTableViewCell
        
        specificCell.setCategoryNameLabel(categoryName: deviationCategories[indexPath.item].categoryName)
        specificCell.setCategoryPath(categoryPath:deviationCategories[indexPath.item].categoryPath)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CategorySelectorTableViewCell
        currentCategory = cell.categoryPath

    }
}

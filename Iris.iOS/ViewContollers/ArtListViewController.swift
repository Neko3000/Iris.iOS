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

class ArtListViewController: UIViewController{

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categorySelectorTwicketSegmentedControl: TwicketSegmentedControl!
    @IBOutlet weak var artListCollectionView: UICollectionView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var categorySelectorTableView: UITableView!
    
    var posts:[UIImage] = [UIImage]()
    var categories:[String] = [String]()
    
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// UICollectionView
extension ArtListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell?
        
        let specificCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtListCollectionViewCell", for: indexPath) as! ArtListCollectionViewCell
        
        specificCell.setArt(art: posts[indexPath.item])
        specificCell.setAuthorName(authorName: "- author\(indexPath.item)")
        
        cell = specificCell
        
        return cell!
    }
}

// UICollectionView - Delegate
extension ArtListViewController:CollectionViewMasonryLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        let post = posts[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: post.size, insideRect: boundingRect)
        
        print("\(indexPath.item): \(post.size.width) - \(post.size.height)")
        
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

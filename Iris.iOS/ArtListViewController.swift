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

class ArtListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categorySelectorTwicketSegmentedControl: TwicketSegmentedControl!
    @IBOutlet weak var artListCollectionView: UICollectionView!
    @IBOutlet weak var toolbarView: UIView!
    
    var posts:[UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        posts.append(UIImage(named: "art-list-ahri-1")!)
        posts.append(UIImage(named: "art-list-ahri-2")!)
        posts.append(UIImage(named: "art-list-ahri-3")!)
        posts.append(UIImage(named: "art-list-ahri-4")!)
        posts.append(UIImage(named: "art-list-ahri-5")!)
        posts.append(UIImage(named: "art-list-ahri-6")!)
        
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
        
        
        //let collectionViewFlowLayout = UICollectionViewFlowLayout()
        //collectionViewFlowLayout.itemSize = CGSize(width: 300, height: 500)
        //artListCollectionView.collectionViewLayout = collectionViewFlowLayout
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
extension ArtListViewController{
    
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

extension ArtListViewController:CollectionViewMasonryLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        let post = posts[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: post.size, insideRect: boundingRect)
        
        print("\(indexPath.item): \(post.size.width) - \(post.size.height)")
        
        return rect.size.height + 29
    }
    
}

//
//  TreeStructureView.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/20/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class TreeStructureView: XibUIView {

    @IBOutlet weak var nodeView: UIView!
    
    var isInitialized:Bool = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            isInitialized = true
        }
    }
    
    open func createTreeStructure(){
        if let path = Bundle.main.path(forResource: "art-categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:Any]]{
                    for node in jsonResult{
                        checkNode(node: node)
                    }
                }
            } catch {
                // handle error
            }
        }
    }
    
    private func checkNode(node:[String:Any]){
        print(node["title"])
    }
}

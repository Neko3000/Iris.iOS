//
//  ResueableView.swift
//  Zizhi.iOS
//
//  Created by Xueliang Chen on 6/2/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class XibUIView: UIView {
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // Use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
        
        // Clear self's color
        self.backgroundColor = .clear
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:String(describing: type(of: self)) , bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
                
        return view
    }
    
}


//
//  ApplyGradient.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 3/22/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

extension CALayer{
    
    func applyGradientBorder(colorus:[CGColor],locations:[NSNumber]?,cornerRadius:CGFloat?) -> Void{
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = colorus
        //gradient.locations = locations
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: self.bounds,cornerRadius:cornerRadius ?? 0).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.insertSublayer(gradient,at:0)
    }
}

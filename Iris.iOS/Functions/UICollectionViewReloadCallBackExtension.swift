//
//  UICollectionViewReloadCallBackExtension.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/8/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

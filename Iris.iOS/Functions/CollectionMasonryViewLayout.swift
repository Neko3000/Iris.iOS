//
//  MasonryCollectionViewLayout.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/18/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

protocol CollectionViewMasonryLayoutDelegate:class {
    func collectionView(collectionView:UICollectionView,heightForCellAt indexPath:IndexPath, with width:CGFloat) -> CGFloat
}

class CollectionViewMasonryLayout: UICollectionViewLayout {
    
    var delegate:CollectionViewMasonryLayoutDelegate?
    
    var columnCount:Int = 2
    var cellPadding:CGFloat = 5.0
    
    var cellHorizontalMargin:CGFloat = 10.0
    var cellVerticalMargin:CGFloat = 2.5
    
    var currentColumn = 0
    var xOffsets:[CGFloat]?
    var yOffsets:[CGFloat]?
    
    private var contentHeight:CGFloat = 0
    private var contentWidth:CGFloat{
        let insets = collectionView!.contentInset
        return (collectionView!.bounds.width - (insets.left + insets.right))
    }
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        
        let columnWidth = contentWidth / CGFloat(columnCount)
        
        if(attributesCache.isEmpty){
            xOffsets = [CGFloat]()
            for i in 0..<columnCount{
                xOffsets!.append(CGFloat(i) * columnWidth)
            }
            
            yOffsets = [CGFloat](repeating: 0, count: columnCount)
        }
        
        for item in attributesCache.count ..< collectionView!.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            
            let cellWidth = columnWidth - cellHorizontalMargin * 2
            
            // Calculate frame
            let cellHeight:CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForCellAt: indexPath, with: cellWidth))!
            
            let blockHeight = cellHeight + cellVerticalMargin * 2
            let frame = CGRect(x: xOffsets![currentColumn], y: yOffsets![currentColumn], width: columnWidth, height: blockHeight)
            let insetFrame = frame.insetBy(dx: cellHorizontalMargin, dy: cellVerticalMargin)
            
            // Create cell attribute
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            attributesCache.append(attribute)
            
            // Update
            contentHeight = max(contentHeight,frame.maxY)
            yOffsets![currentColumn] = yOffsets![currentColumn] + blockHeight
            
            currentColumn = (currentColumn + 1) % 2
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in attributesCache{
            if attribute.frame.intersects(rect){
                layoutAttributes.append(attribute)
            }
        }
        
        return layoutAttributes
    }
    
    func resetLayout(){
        currentColumn = 0
        contentHeight = 0
        
        attributesCache.removeAll()
    }
}

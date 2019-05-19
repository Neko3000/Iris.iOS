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
    
    private var contentHeight:CGFloat = 0
    private var contentWidth:CGFloat{
        let insets = collectionView!.contentInset
        return (collectionView!.bounds.width - (insets.left + insets.right))
    }
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        if attributesCache.isEmpty{
            let columnWidth = contentWidth/CGFloat(columnCount)
            
            var xOffsets = [CGFloat]()
            for column in 0..<columnCount{
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: columnCount)
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
                
                let cellWidth = columnWidth - cellHorizontalMargin * 2
                
                // Calculate the frame
                let cellHeight:CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForCellAt: indexPath, with: cellWidth))!
                
                let height = cellPadding + cellHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellHorizontalMargin, dy: cellVerticalMargin)
                
                // Create cell attribute
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = insetFrame
                attributesCache.append(attribute)
                
                // update column, yOffset
                contentHeight = max(contentHeight,frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                
                column += 1
                column = column % 2
            }
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
}

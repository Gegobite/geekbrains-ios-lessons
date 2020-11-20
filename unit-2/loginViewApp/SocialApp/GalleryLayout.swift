//
//  GalleryLayout.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.10.2020.
//

import UIKit

class GalleryLayout: UICollectionViewLayout {
    
    var cacheAtributes = [IndexPath: UICollectionViewLayoutAttributes]()
    
    var columsCount = 2
    
    var totalCellsHeight: CGFloat = 0
    
    override func prepare() {
        self.cacheAtributes = [:]
        guard let collectionView = self.collectionView else { return }
        let itemCount = collectionView.numberOfItems(inSection: 0)
        guard itemCount > 0 else { return }
        
        var lastX: CGFloat = 5
        var lastY: CGFloat = 5
        
        let cellSize = (collectionView.frame.width - 20) / CGFloat(columsCount)
        
        for index in 0..<itemCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: lastX, y: lastY, width: cellSize, height: cellSize)
            let isLastColumn = (index + 1) % self.columsCount == 0
            if isLastColumn {
                lastY += cellSize + 5
                lastX = 5
            } else {
                lastX += cellSize + 5
            }
            cacheAtributes[indexPath] = attributes
            totalCellsHeight = lastY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAtributes.values.filter { (attr) in
            return rect.intersects(attr.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAtributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellsHeight)
    }
}

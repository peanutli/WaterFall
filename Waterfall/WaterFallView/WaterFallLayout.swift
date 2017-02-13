//
//  WaterFallLayout.swift
//  Waterfall
//
//  Created by 花生 on 17/2/13.
//  Copyright © 2017年 花生. All rights reserved.
//

import UIKit

class WaterFallLayout: UICollectionViewFlowLayout {
    fileprivate var startIndex = 0
    fileprivate var maxH : CGFloat = 0
    fileprivate var colCount : Int = 2
    fileprivate lazy var attsArray = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var colHeights :[CGFloat] = {
        var colHeights = Array(repeating: self.sectionInset.top, count: self.colCount)
        return colHeights
    }()
 
}

extension WaterFallLayout{
    
    override func prepare() {
        super.prepare()
        
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //获取item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        //获取列数
        
        //计算item的宽度
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(colCount - 1)) / CGFloat(colCount)
        
        //计算item的属性
        for i in startIndex..<itemCount {
            // 1.设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            // 2.根据位置创建Attributes属性
            let att = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 3.随机一个高度
            let attH :CGFloat = CGFloat(arc4random() % 100 + 100)
            // 4.取出最小的位列
            var minH :CGFloat = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + self.minimumLineSpacing + attH
            colHeights[index] = minH
            //5.设置itme的frame
            att.frame = CGRect(x: self.sectionInset.left + (self.minimumLineSpacing + itemW) * CGFloat(index), y: minH - attH - self.minimumLineSpacing, width: itemW, height: attH)
            
            attsArray.append(att)
            maxH = colHeights.max()!
        
        }
    }
}

extension WaterFallLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attsArray
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: maxH + self.sectionInset.bottom - self.minimumLineSpacing)
    }
}


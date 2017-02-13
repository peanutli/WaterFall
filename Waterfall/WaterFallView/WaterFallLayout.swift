//
//  WaterFallLayout.swift
//  Waterfall
//
//  Created by 花生 on 17/2/13.
//  Copyright © 2017年 花生. All rights reserved.
//

import UIKit

@objc protocol WaterFallLayoutDatasource : class {
    func waterFallLayout(_ layout:WaterFallLayout,indexPath:IndexPath) -> CGFloat
    @objc optional func numberOfColsInWaterfallLayout(_ layout:WaterFallLayout) -> Int
}

class WaterFallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource : WaterFallLayoutDatasource?
    fileprivate var startIndex = 0
    fileprivate var maxH : CGFloat = 0
    fileprivate lazy var attsArray = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var colHeights :[CGFloat] = {
        let colCount = self.dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count:colCount)
        return colHeights
    }()
 
}

extension WaterFallLayout{
    
    override func prepare() {
        super.prepare()
        //获取item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        //获取列数
        let colCount = self.dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        //计算item的宽度
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(colCount - 1)) / CGFloat(colCount)
        
        //计算item的属性
        for i in startIndex..<itemCount {
            
            // 1.设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            // 2.根据位置创建Attributes属性
            let att = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 3.随机一个高度
            guard let attH = dataSource?.waterFallLayout(self, indexPath: indexPath) else {
                fatalError("没有设置并实现数据源方法")
            }
            
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


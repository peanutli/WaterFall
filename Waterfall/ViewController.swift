//
//  ViewController.swift
//  Waterfall
//
//  Created by 花生 on 17/2/13.
//  Copyright © 2017年 花生. All rights reserved.
//

import UIKit

let kCellIdentifier = "cellIdentifier"
let kNumberOfCols = 5
let kNumberOfItemsInSection = 100
let kEdgeMargin : CGFloat = 10.0


class ViewController: UIViewController {

    fileprivate lazy var  collectionView : UICollectionView = {
        let layout  = WaterFallLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:kCellIdentifier
        )
        collectionView.dataSource = self
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kNumberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension ViewController : WaterFallLayoutDatasource{
    func waterFallLayout(_ layout: WaterFallLayout, indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random() % 100 + 100)
    }
    
    func numberOfColsInWaterfallLayout(_ layout: WaterFallLayout) -> Int {
        return kNumberOfCols
    }
}


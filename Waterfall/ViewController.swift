//
//  ViewController.swift
//  Waterfall
//
//  Created by 花生 on 17/2/13.
//  Copyright © 2017年 花生. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ViewController: UIViewController {

    fileprivate lazy var  collectionView : UICollectionView = {
        let layout  = WaterFallLayout()
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:cellIdentifier
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
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}


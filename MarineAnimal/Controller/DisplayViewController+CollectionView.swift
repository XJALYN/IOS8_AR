//
//  DisplayViewController+CollectionView.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/13.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
import SceneKit

extension DisplayViewController:UICollectionViewDelegate,UICollectionViewDataSource{

    func initCollectionView(){

        
        self.collectionView.register(UINib(nibName: "DisplayCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: 80, height: 80)
        flowlayout.minimumLineSpacing = 10
        flowlayout.minimumInteritemSpacing = 10
        flowlayout.scrollDirection = .horizontal
        self.collectionView.setCollectionViewLayout(flowlayout, animated: false)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.clear
        
        self.detailTextView.text = self.localizedStringForKey(Marine.animals[0].rawValue, defaultValue: "NO Recoder", bundleName: "DisplayView")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DisplayCell
        cell.imageView.image = Marine.animals[indexPath.row].image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Marine.animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animation = Marine.animals[indexPath.row]
        self.displayAnimation(animation.node)
        self.detailTextView.text = self.localizedStringForKey(animation.rawValue, defaultValue: "NO", bundleName: "DisplayView")
        
        
    }
    
    
}

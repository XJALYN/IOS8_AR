//
//  ViewController.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/13.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit
import SceneKit

class DisplayViewController: UIViewController {
    

    @IBOutlet weak var arView: ARView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detialBackgroundView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var showDetailButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initCollectionView()
        self.setupScnView()
        self.displayAnimation(Marine.animals[0].node)

    }

    @IBAction func showDetailView(_ sender: Any) {
        self.detialBackgroundView.isHidden = false
    }
    
    @IBAction func hiddenDetailView(_ sender: Any) {
        self.detialBackgroundView.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}


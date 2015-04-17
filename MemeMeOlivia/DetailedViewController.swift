//
//  DetailedViewController.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/15/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
    }
}

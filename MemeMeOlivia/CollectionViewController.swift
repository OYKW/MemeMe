//
//  CollectionViewController.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/16/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import UIKit

let reuseIdentifier = "MyCollectionCell"

class CollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        let thisMeme = memes[indexPath.row]
        cell.memedImageView.image = thisMeme.memedImage
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as! DetailedViewController
        detailController.meme = memes[indexPath.row]
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }

    
}

//
//  TableViewController.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/15/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource {

    var memes: [Meme]!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.memes = applicationDelegate.memes
        
        //If there are no sent memes present the meme editor
        if self.memes.isEmpty == true {
            let editorController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorNav") as! UINavigationController
            self.presentViewController(editorController, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes!.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyTableCell", forIndexPath: indexPath) as! UITableViewCell

        let myMeme = memes[indexPath.row]
        
        // Customize table cell using tags
        var cellTopLabel = cell.viewWithTag(2) as! UILabel
        var cellButtomLabel = cell.viewWithTag(3) as! UILabel
        var cellImageView = cell.viewWithTag(1) as! UIImageView
        
        cellTopLabel.text = myMeme.topText
        cellButtomLabel.text = myMeme.buttomText
        cellImageView.image = myMeme.memedImage
        
        

        return cell
    }
    
    // MARK: - Table view delegate: show the detailed view
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as! DetailedViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }

}

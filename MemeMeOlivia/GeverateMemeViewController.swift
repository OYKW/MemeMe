//
//  GeverateMemeViewController.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/10/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import UIKit

class GeverateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        
        self.topTextField.delegate = self
        self.buttomTextField.delegate = self
        
        // Set text attributes for both the text and the placeholder in the two text fields
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2.0
            
        ]
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.buttomTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        self.buttomTextField.attributedPlaceholder = NSAttributedString(string: "BUTTOM", attributes: memeTextAttributes)
        
        // Make font size adjustable
        self.topTextField.adjustsFontSizeToFitWidth = true
        self.topTextField.minimumFontSize = 20
        self.buttomTextField.adjustsFontSizeToFitWidth = true
        self.buttomTextField.minimumFontSize = 20
        
        self.topTextField.textAlignment = NSTextAlignment.Center
        self.buttomTextField.textAlignment = NSTextAlignment.Center
        
        super.viewDidLoad()
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Disable the camera button is camera is not available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera)
        
        // Disable the shareButton initially before any picture chosen
        shareButton.enabled = (self.imageView.image != nil)
        
        self.topTextField.placeholder = "TOP"
        self.topTextField.enabled = (self.imageView.image != nil)
        self.buttomTextField.placeholder = "BUTTOM"
        self.buttomTextField.enabled = (self.imageView.image != nil)
        
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: Move the view when the keyboard for the buttom textfield shows
    
    func keyboardWillShow(notification: NSNotification) {
        if self.buttomTextField.editing {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.buttomTextField.editing {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        // Test whether the camera button or the "Album" button is pressed
        if sender as! NSObject == cameraButton {
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else if sender as! NSObject == albumButton {
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        pickerController.allowsEditing = true
        self.presentViewController(pickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
   // MARK: Generate memed image, and create a Meme object
    
    func generateMemedImage() -> UIImage {
        // First hide the navigation bar and the tool bar
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show the navigation bar and the tool bar again
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.toolbar.hidden = false
        
        return memedImage
    }
    
    // Save a Meme object
    func save() {
        var meme = Meme(topText: topTextField.text, buttomText: buttomTextField.text, originalImage: imageView.image!, memedImage: generateMemedImage())
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        applicationDelegate.memes.append(meme)
        
    }
  
    // Present an activity controller and upon completion save the data and show SentMemes view
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionHandler = {(activityType, completed: Bool) in
            if !completed {
                println("Sharing failed. ")
                return
            } else {
                self.save()
                //self.dismissViewControllerAnimated(true, completion: nil)
                let tabController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                self.presentViewController(tabController, animated: true, completion: nil)
            }
        }
        
    }
    


}


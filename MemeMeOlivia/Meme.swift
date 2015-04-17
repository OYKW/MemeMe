//
//  Meme.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/14/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    var topText: String!
    var buttomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    init(topText: String, buttomText: String, originalImage: UIImage, memedImage: UIImage){
        
        self.topText = topText
        self.buttomText = buttomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    

    
    
}

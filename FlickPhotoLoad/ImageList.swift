//
//  ImageList.swift
//  FlickPhotoLoad
//
//  Created by Prakhar Tripathi on 11/01/18.
//  Copyright © 2018 Prakhar Tripathi. All rights reserved.
//

import Foundation

class ImageList{
    
    var farm:String
    var server:String
    var id:String
    var secret:String
    
    init(f:String, ser:String, i:String, sec:String) {
        self.farm = f
        self.server = ser
        self.id = i
        self.secret = sec
    }
}

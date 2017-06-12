//
//  CLPictureModel.swift
//  stwitter
//
//  Created by sun on 2017/6/6.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLPictureModel: NSObject {
    /// 缩略图地址
    var thumbnail_pic: String?
    
    override var description: String{
        return yy_modelDescription()
    }

}

//
//  CLStatusModel.swift
//  stwitter
//
//  Created by sun on 2017/5/25.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

import YYModel
class CLStatusModel: NSObject {
    var id:Int64 = 0
    var text:String?
    //计算型属性
    override var description: String{
        return yy_modelDescription()
    }
}

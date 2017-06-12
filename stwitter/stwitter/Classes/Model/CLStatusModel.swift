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
    
    var user:CLUserModel?
    
    /// 转发数
    var reposts_count: Int = 0
    
    /// 评论数
    var comments_count: Int = 0
    
    /// 点赞数
    var attitudes_count: Int = 0
    
    /// 微博配图模型数组
    var pic_urls: [CLPictureModel]?
    
    /// 被转发微博
    var retweeted_status: CLStatusModel?
     
    
    //计算型属性
    override var description: String{
        return yy_modelDescription()
    }
    
    //容器类（如果遇到数组类型的属性，告诉YY_model 数组中存放的对象是什么类）
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": CLPictureModel.self]
    }
}

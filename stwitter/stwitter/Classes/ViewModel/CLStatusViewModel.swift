//
//  CLStatusViewModel.swift
//  stwitter
//
//  Created by sun on 2017/6/2.
//  Copyright © 2017年 sun. All rights reserved.
//

import Foundation
/**
 如果没有任何父类 希望在开发是调试 输出调试信息
 1.遵守CustomStringConvertible 协议
 2.实现 description 计算型属性
 关于表格性能优化
 尽量少计算 所有需要的素材提前计算好
 控件上不要设置圆角半径 所有图像渲染的属性 都要注意
 不要动态创建控件 所有的控件提前创建好 在显示的时候 根据数据隐藏/显示
 cell中控件的层次太少 数量越少越好
 */
class CLStatusViewModel:CustomStringConvertible{
    var status: CLStatusModel
    
    
    var memberIcon:UIImage?
    
    /// 转发
    var retweetedStr: String?
    
    /// 评论
    var commentStr: String?
    
    /// 点赞
    var likeStr: String?
    
    var pictureViewSize = CGSize()
    
    var retweetText:String?
    
    /// 如果是被转发的微博，原创微博一定没有图
    var picUrls:[CLPictureModel]?{
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    
    init(model:CLStatusModel) {
       self.status = model
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: " 评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: " 赞")
        
        pictureViewSize = calPictureViewSize(count: picUrls?.count)
        
        retweetText = "@" + (model.retweeted_status?.user?.screen_name ?? "") + ":" +  (model.retweeted_status?.text ?? "")
        
    }
    
    
    
    
    var description: String{
        return status.description
    }
    
    fileprivate func countString(count:Int,defaultStr: String)->String{
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万",  Double(count / 10000))
    }
    fileprivate func calPictureViewSize(count:Int?) ->CGSize{
        if count == 0 || count == nil {
            return CGSize()
        }
        
        let row  = (count! - 1) / 3 + 1
        
        
        /// 每个Item 默认的高宽度
        
        
        let height = pictureOutterMargin + CGFloat(row) * CLStatusPictureItemWith + CGFloat(row - 1) * pictureInnerMargin
        
        return CGSize.init(width: CLStatusPictureItemWith, height: height)
        
        
    }
}

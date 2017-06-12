//
//  StwitterHelper.swift
//  stwitter
//
//  Created by sun on 2017/5/27.
//  Copyright © 2017年 sun. All rights reserved.
//

import Foundation

//MARK: - 应用程序信息
//应用程序 ID
let CLAppKey = "2354568521"
//应用程序加密信息（开发者可以申请修改）
let CLAppSecret = "b84a4b28bcb1d9b0eb37f05e7b939534"
//回调地址 登录完成的跳转 URL 参数以 get 形式拼接
let CLRedirectURL = "http://www.baidu.com"

//新浪微博用户名
let KUsername  = "18627930936"
//新浪微博密码
let KPassword = "qazwsx123123"
/// 用户需要登录通知
let CLUserShouldLoginNotification = "CLUserShouldLoginNotification"

/// 成功登录通知
let CLUserLoginSuccessedNotification = "CLUserLoginSuccessedNotification"

/// 配图视图外侧的间距
let pictureOutterMargin = CGFloat(12)
/// 配图视图内侧的间距
let pictureInnerMargin = CGFloat(3)
/// 视图 总宽度
let CLStatusPictureViewWidth = UIScreen.yw_screenWidth() - 2 * pictureOutterMargin

let CLStatusPictureItemWith = (CLStatusPictureViewWidth - 2 * pictureInnerMargin) / 3


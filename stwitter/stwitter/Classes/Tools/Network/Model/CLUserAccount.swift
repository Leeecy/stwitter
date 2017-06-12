
//
//  CLUserAccount.swift
//  stwitter
//
//  Created by sun on 2017/5/27.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

private let accountFile: NSString = "userAccount.json"

class CLUserAccount: NSObject {
    /// 访问令牌
    var access_token: String?
    
    /// 用户代号
    var uid: String?
    
    //用户昵称
    var screen_name: String?
    //用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    /// access_token 的生命周期 开发者5年 使用者3天
    
    var expires_in:TimeInterval = 0{
        didSet{
            expiresDate = Date.init(timeIntervalSinceNow: expires_in)
        }
    }
    
    //过期日期
    var expiresDate: Date?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        //从磁盘加载保存文件
        guard let path = accountFile.yw_appendDocumentDir(),
            let data = NSData(contentsOfFile: path),
            let dic = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]
            else {
                return
        }
        //使用字典设置属性值
        yy_modelSet(with: dic ?? [:])
        
        print("从沙盒加载用户信息\(self)")
        //测试日期
//                expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
        //判断 token 是否过期
        if  expiresDate?.compare(Date()) == .orderedAscending {
            //账户过期 清空 token uid
            access_token = nil
            uid = nil
            //删除账户文件
            _ = try?FileManager.default.removeItem(atPath: path)
            
        }

    }
    
    
    func saveAccount() {
        var dict = (self.yy_modelToJSONObject() as? [String:Any]) ?? [:]
        dict.removeValue(forKey: "expires_in")
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let filePath = accountFile.yw_appendDocumentDir() else{
                return
        }
        
        
        (data as NSData).write(toFile: filePath, atomically: true)
        
        print("账户保存成功\(filePath)")
    }
    

}

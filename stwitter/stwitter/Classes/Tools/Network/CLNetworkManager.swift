//
//  CLNetworkManager.swift
//  stwitter
//
//  Created by sun on 2017/5/23.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

import AFNetworking

enum CLHTTPMethod {
    case POST
    case GET
}

class CLNetworkManager: AFHTTPSessionManager {
//    单例
    static let shared: CLNetworkManager = {
    
        //实例化对象
        let instance = CLNetworkManager()
        //设置响应反序列化支持的类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        //返回对象
        return instance
    }()
    
    //var accessToken:String? //= "2.00rc5VOCdpW2ZC252396604bs_ELsC"
//    var uid:String = "2354568521"
    
    lazy var userAccount = CLUserAccount()
    
    
    var userLogin:Bool {
        return userAccount.access_token != nil
    }
    
    
    
//    MARK -  token封装
    func tokenRequest(method:CLHTTPMethod = .GET,URLString:String,parameters:[String:Any]?,completion: @escaping (_ json: Any?, _ isSuccess: Bool) ->()) {
        
       guard let token = userAccount.access_token else {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLUserShouldLoginNotification), object: nil, userInfo: nil)
            completion(nil, false)
            return
        
        }
        var parameters = parameters
        if parameters == nil {
            parameters = [String: Any]()
        }
        //设置参数字典,代码在此一定不会为nil
        parameters?["access_token"] = token as Any?
        
        
        
        request(URLString: URLString, parameters: parameters!, completion: completion)
    }
    
    
//    func request(method:CLHTTPMethod = .GET,URLString:String,parameters:[String:Any],completion:@escaping (_ json: Any?, _ isSuccess: Bool) -> Void)
    

    
    func request(method:CLHTTPMethod = .GET,URLString:String,parameters:[String:Any],completion: @escaping (_ json: Any?, _ isSuccess: Bool) ->()){
        
        let success = { (task:URLSessionDataTask,json:Any?) -> ()in
            
            completion(json,true)
            
        }
        let failure = { (task:URLSessionDataTask?,error:Error) -> () in
        
            if (task?.response as? HTTPURLResponse)?.statusCode == 403{
    
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLUserShouldLoginNotification), object: "bad Token", userInfo: nil)
            
            }
            print("网络请求错误\(error)")
            completion(nil,false)
        }
        /// Cannot convert value of type '(URLSessionDataTask?, NSError) -> ()' to expected argument type '((URLSessionDataTask?, Error) -> Void)?'
        
        if method == .GET {
           get(URLString, parameters: parameters, progress: nil, success:success,failure:failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
        
    }
    
    

}

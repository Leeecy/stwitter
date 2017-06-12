//
//  CLNetworkManager+Extension.swift
//  stwitter
//
//  Created by sun on 2017/5/24.
//  Copyright © 2017年 sun. All rights reserved.
//

import Foundation

extension CLNetworkManager{
    func statusList(since_id:Int64 = 0,max_id:Int64 = 0,completion:@escaping (_ list:[[String: Any]]?,_ isSuccess:Bool)->()) {
        //      let urlString =  "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=6"
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
//        let params = ["since_id": since_id, "max_id": max_id > 0 ?max_id - 1 : 0]
        let params = ["since_id": since_id, "max_id": max_id > 0 ?max_id - 1 : 0] as [String : Any]
        
        
        tokenRequest(URLString: urlString, parameters: params as [String : Any]!) { (jsonDict,isSuccess) in
        

            let dic = jsonDict as? Dictionary<String,Any>
            guard let result = dic?["statuses"] as?[[String:Any]] else{
                return
            }
            
//            let dic = jsonDict as! [String:Any]
            
//            print("json---\(dic["statuses"])")
            
         
            /// Type 'Any' has no subscript members
//            let result = dic["statuses"] as?[[String:Any]]
            
            completion(result, isSuccess)
        }

    }
    
    func unreadCount(completion:@escaping (_ unreadCount:Int) ->()) {
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlStr = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        
        tokenRequest(URLString: urlStr, parameters: params) { (json, isSuccess) in
            print("unread---\(String(describing: json))")
            let dic = json as?[String:Any]
            
            let unreadCount = dic?["status"] as? Int
            completion(unreadCount ?? 0)
        }
        
    }
    
}
//MARK -用户信息
extension CLNetworkManager{
    func loadUserInfo(completion:@escaping (_ dict: [String:Any])->()) {
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let  params = ["uid":uid]
        
        tokenRequest(URLString: urlStr, parameters: params) { (json, isSuccess) in
            print(json ?? [:])
            completion(json as? [String : Any] ?? [:])
            
        }
    }
}

//MARK -OAuth
extension CLNetworkManager{
    func loadAccessToken(code:String,completion:@escaping (_ isSuccess: Bool)->()){
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id":CLAppKey,
                      "client_secret":CLAppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":CLRedirectURL
                      ]
        
        request(method: .POST, URLString: urlStr, parameters: params) { (json, isSuccess) in
//            print("json---\(String(describing: json))")
            //字典-》模型
            self.userAccount.yy_modelSet(with: json as? [String : Any] ?? [:])
            
            self.loadUserInfo(completion: { (json) in
                print("userAccount---\(self.userAccount)")
                self.userAccount.yy_modelSet(with: json)
                self.userAccount.saveAccount()
                completion(isSuccess)
            })
           
        }
        
        
    }
}

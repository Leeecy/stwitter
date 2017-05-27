//
//  CLStatusListViewModel.swift
//  stwitter
//
//  Created by sun on 2017/5/25.
//  Copyright © 2017年 sun. All rights reserved.
//

import Foundation

//上拉刷新最大尝试次数
fileprivate let maxPullupTryTimes = 3

class CLStatusListViewModel{
    lazy var statusList = [CLStatusModel]()
    
    ///上拉刷新错误次数
    fileprivate var pullupErrorTimes = 0
    /// - parameter pullup: 是否上拉刷新标记
    /// - parameter completion: 完成回调[网络请求是否成功/是否刷新表格]
    
    func loadStatus(isPullup:Bool,completion:@escaping (_ isSuccess:Bool, _ shouldRefresh: Bool)->()) {
        
        if isPullup && self.pullupErrorTimes > maxPullupTryTimes{
            completion(true, false)
            return
        }
        
        let since_id = isPullup ? 0 :(statusList.first?.id ?? 0)
        
        let max_id = !isPullup ? 0 : (statusList.last?.id ?? 0)
        
        
        CLNetworkManager.shared.statusList (since_id:since_id,max_id:max_id) { (list, isSuccess) in
            
            
            
            
            //上拉 下拉 只能存在一种 since_id 和max_id  同时只能一个有值 另一个为 默认值 0
            // since_id 取出数组中第一条微博的 id
            
            
            //字典转模型
            guard let array = NSArray.yy_modelArray(with: CLStatusModel.self, json: list ?? []) as? [CLStatusModel] else{
                completion(isSuccess, false)
                return
            }
            print("刷新到\(array.count) 条数据")
            
            if isPullup{
                self.statusList += array
            }else{
                //下拉
                self.statusList = array + self.statusList
            }
            
            if isPullup && array.count == 0{
                self.pullupErrorTimes += 1
                //完成回调
                completion(isSuccess, false)
            }else{
                completion(isSuccess, true)
            }
            
            
            
        }
    }
}

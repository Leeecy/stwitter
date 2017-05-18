//
//  CLMainViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/17.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLMainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControlers()
        
    }
}


extension CLMainViewController{
    
    fileprivate func setupChildControlers(){
        let array = [
            ["clsName":"CLHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"CLMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"CLDiscoverViewController","title":"发现","imageName":"discover"],
            ["clsName":"CLProfileViewController","title":"我","imageName":"profile"]
        
        ]
        
        var arrayM = [UIViewController]()
        
        for dict in array {
            arrayM.append(controllers(dict: dict))
        }
        
        viewControllers = arrayM
    
    }
    
    
   fileprivate func controllers(dict:[String:String]) -> UIViewController{
        guard let clsName = dict["clsName"],
               let title = dict["title"],
               let imageName = dict["imageName"],
               let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? CLBaseViewController.Type else{
        
                return UIViewController()
        }
        
        //2 创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        vc.tabBarItem.image = UIImage.init(named: "tabbar_" + imageName)
        
        vc.tabBarItem.selectedImage = UIImage.init(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        let nav = CLNavgationController(rootViewController: vc)
        return nav
        
        
    }



}

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
        setupComposeButton()
    }
    //MARK: -监听方法
    @objc fileprivate func composeStatus(){
        print(#function)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    
    fileprivate lazy var composeBtn:UIButton = UIButton.yw_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
}


extension CLMainViewController{
    
    fileprivate func setupComposeButton(){
        tabBar.addSubview(composeBtn)
        
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1
        
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
    
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    fileprivate func setupChildControlers(){
        let array = [
            ["clsName":"CLHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"CLMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"UIViewController"],
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
    
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)
    vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)
        let nav = CLNavgationController(rootViewController: vc)
        return nav
        
        
    }



}

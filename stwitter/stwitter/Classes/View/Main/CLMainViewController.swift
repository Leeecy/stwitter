//
//  CLMainViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/17.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit
import SVProgressHUD
class CLMainViewController: UITabBarController {
    // 定时器
    fileprivate var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControlers()
        setupComposeButton()
        setupTimer()
        
        
        setupNewfeatureView()
        //
        delegate = self //as? UITabBarControllerDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: CLUserShouldLoginNotification), object: nil)
        
    }
    
    @objc fileprivate func userLogin(n:Notification) -> () {
        print("用户登录通知\(n)")
        var deadlineTime = DispatchTime.now()
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需要重新登录")
            //修改延迟时间
            deadlineTime = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            SVProgressHUD.setDefaultMaskType(.clear)
            //展现登录控制器
            let nav = UINavigationController.init(rootViewController: CLOAuthViewController())
            
            self.present(nav, animated: true, completion: nil)
        }

        
      
        
    }
    
    deinit {
       timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
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
extension CLMainViewController:UITabBarControllerDelegate{
    
    /// TabBarItem
    ///
    /// - Parameters:
    ///   - tabBarController:
    ///   - viewController: 控制器
    /// - Returns:
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        let index = childViewControllers.index(of: viewController)
        //当前索引
        if selectedIndex == 0 && index == selectedIndex{
            print("点击首页")
            
            let nav = childViewControllers[0] as?UINavigationController
            let vc = nav?.childViewControllers[0] as!CLHomeViewController
            
//            vc.tableView?.setContentOffset(CGPoint.init(x: 0, y: -64), animated: true)
            vc.tableView?.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            
            //刷新数据
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
            
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
        
        
        
        //判断目标控制器是否是 UIViewController 不包含子类
        return !viewController.isMember(of: UIViewController.self)
    }
}

//MARK-  timer
extension CLMainViewController{
    fileprivate func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func updateTimer() {
        print(#function)
        if !CLNetworkManager.shared.userLogin  {
            return
        }
        
        
        CLNetworkManager.shared.unreadCount { (count) in
            print("检测到\(count)条未读")
            
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
        
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

extension CLMainViewController{
    
    fileprivate func setupComposeButton(){
        tabBar.addSubview(composeBtn)
        
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count //- 1
        
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
    
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    fileprivate func setupChildControlers(){
        
//        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let jsonPath = (docDir as? NSString)?.appendingPathComponent("main.json")
//        
//        let data = NSData.init(contentsOfFile: jsonPath!)
//        
//        if data == nil {
//            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
//            data = NSData.init(contentsOfFile: path)
//        }
//        
        
        
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
            let data = NSData.init(contentsOfFile: path),
        let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String: Any]]
        else {
            
            return
        }
        
        
        
        
//        let array :[[String:Any]] = [
//            ["clsName":"CLHomeViewController","title":"首页","imageName":"home","visitorInfo" : ["imageName": "","message":"关注一些人，回这里看看有什么惊喜"]],
//            ["clsName":"CLMessageViewController","title":"消息","imageName":"message_center","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
//            ["clsName":"UIViewController"],
//            ["clsName":"CLDiscoverViewController","title":"发现","imageName":"discover","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，最新、最热的微博尽在掌握中，不会再于实事潮流擦肩而过"]],
//            ["clsName":"CLProfileViewController","title":"我","imageName":"profile","visitorInfo" : ["imageName": "visitordiscover_image_profile","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
//        
//        ]
//        
    
//        
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        
//        (data as NSData).write(toFile: "/Users/a/Desktop/Demo.json", atomically: true)
        var arrayM = [UIViewController]()
        
        for dict in array! {
            
            arrayM.append(controllers(dict:dict))
        }
        
        viewControllers = arrayM
    
    }

    //Cast from '(key: String, value: Any)' to unrelated type '[String : Any]' always fails
    /// Cannot convert value of type '(key: String, value: Any)' to expected argument type '[String : Any]'

   fileprivate func controllers(dict:[String:Any]) -> UIViewController{
        guard let clsName = dict["clsName"] as? String,
               let title = dict["title"] as? String,
               let imageName = dict["imageName"] as? String,
                let visitorDict = dict["visitorInfo"] as? [String:String],
               let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? CLBaseViewController.Type else{
        
                return UIViewController()
        }
        
        //2 创建视图控制器
        let vc = cls.init()
        vc.title = title
    
        vc.visitorInfoDict = visitorDict
    
        vc.tabBarItem.image = UIImage.init(named: "tabbar_" + imageName)
        
        vc.tabBarItem.selectedImage = UIImage.init(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
    
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)
    vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)
        let nav = CLNavgationController(rootViewController: vc)
        return nav
        
        
    }

}

// MARK: - 新特性视图处理
extension CLMainViewController {
    
    fileprivate func setupNewfeatureView(){
        //判断是否登录
        if !CLNetworkManager.shared.userLogin {
            
            return
        }
        
        let v = isNewVersion ? CLNewFeatureView.newFeatureView() : CLWelcomeView.welcomeView()
        view.addSubview(v)

    }
    
    private var isNewVersion:Bool{
        //取出当前是版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        //取出保存在偏好设置的版本号
        let beforeVersion = UserDefaults.standard.string(forKey: "CLVersionKey") ?? ""
        
        //将当前的版本号偏好设置
        UserDefaults.standard.set(currentVersion, forKey: "CLVersionKey")
        
        //返回 连个版本号是否一致
        return currentVersion != beforeVersion
    }

}

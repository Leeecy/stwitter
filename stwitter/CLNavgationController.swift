//
//  CLNavgationController.swift
//  stwitter
//
//  Created by sun on 2017/5/18.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLNavgationController: UINavigationController {

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? CLBaseViewController {
                var title  = "返回"
                
                title = childViewControllers.first?.title ?? "返回"
                
                
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: title, fontSize: 16, target: self, action: #selector(popToParent), isBack: true)
                
            }
        }
        
       
        
        
        
        super.pushViewController(viewController, animated: true)
        
    }
    
    @objc fileprivate func popToParent() -> () {
        print(#function)
        popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

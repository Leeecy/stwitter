//
//  CLBaseViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/17.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLBaseViewController: UIViewController {

    var tableView:UITableView?
    
    
    lazy var navigationBar = UINavigationBar.init(frame:CGRect.init(x: 0, y: 0, width: UIScreen.yw_screenWidth(), height: 64))
    
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var title:String?{
        didSet{
            navItem.title = title
        }
    }
    


}
//MARK:-设置界面
extension CLBaseViewController{
    func setupUI() -> () {
        setupNavigationBar()
        setupTableView()
    }
    
    fileprivate func setupTableView(){
        tableView = UITableView.init(frame: view.bounds,style: .plain)
        view.addSubview(tableView!)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    fileprivate func setupNavigationBar(){
        view.backgroundColor = UIColor.yw_random()
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        navigationBar.barTintColor = UIColor.yw_color(withHex: 0xf6f6f6)
        //设置navBar 的标题字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        //设置系统按钮的文字渲染颜色  只对系统.plain 的方法有效
        navigationBar.tintColor = UIColor.orange

    }
}

extension CLBaseViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}






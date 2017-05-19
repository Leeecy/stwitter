//
//  CLHomeViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/18.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class CLHomeViewController: CLBaseViewController {

    fileprivate lazy var statusList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<10 {
            statusList.insert(i.description, at: 0)
        }

    }


    override func loadData() {
        
    }
    
    @objc fileprivate func showFridens(){
        print(#function)
    }

}
//MARK: - 数据源方法
extension CLHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for:indexPath)
        cell.textLabel?.text = "测试数据" + statusList[indexPath.row]
        return cell
    }
}

extension CLHomeViewController{
    override func setupUI() {
        super.setupUI()
        
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, action: #selector(showFridens))
        
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
    }
    
    
}

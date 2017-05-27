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

    fileprivate lazy var listViewModel = CLStatusListViewModel()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func loadData() {
        
        listViewModel.loadStatus(isPullup: self.isPullup) { (isSuccess,shouldRefresh) in
            print("加载数据结束")
            
            self.refreshControl?.endRefreshing()
            
            self.isPullup = false
            
            if shouldRefresh{
                self.tableView?.reloadData()
            }
            
            
        }
        
        print("--------\(CLNetworkManager.shared)")
        
        CLNetworkManager.shared.statusList {_,_ in 
            
        }
        
       
    }
    
    @objc fileprivate func showFridens(){
        print(#function)
    }

}
//MARK: - 数据源方法
extension CLHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for:indexPath)
        /// Cannot assign value of type 'CLStatusModel' to type 'String?'
        cell.textLabel?.text =  listViewModel.statusList[indexPath.row].text
        return cell
    }
}

extension CLHomeViewController{
    override func setupTableView() {

        super.setupTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, action: #selector(showFridens))
        
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
    }
    
    
    
    
}

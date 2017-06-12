//
//  CLHomeViewController.swift
//  stwitter
//
//  Created by sun on 2017/5/18.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

private let cellId = "cellId"
// 转发微博
private let retweetedCellId = "retweetedCellId"
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
        let viewModel = listViewModel.statusList[indexPath.row]
        let cellId1 = (viewModel.status.retweeted_status != nil) ? retweetedCellId : cellId
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId1,for:indexPath) as! CLStatusCell
        /// Cannot assign value of type 'CLStatusModel' to type 'String?'
        
        
        cell.viewModel = viewModel

        return cell
    }
}

extension CLHomeViewController{
    override func setupTableView() {

        super.setupTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, action: #selector(showFridens))
        
        
//        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView?.register(UINib (nibName: "CLStatusCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        tableView?.register(UINib (nibName: "CLStatusRetweedCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        tableView?.separatorStyle = .none
        
        setupNavTitle()
    }
    
    fileprivate func setupNavTitle(){
        let btn = CLTitleButton(title: CLNetworkManager.shared.userAccount.screen_name)
        navItem.titleView = btn
        btn.addTarget(self, action: #selector(titleBtnAction), for: .touchUpInside)
    }
    
    @objc fileprivate func titleBtnAction(btn:UIButton){
        //设置选中状态
        btn.isSelected = !btn.isSelected
        
    }
    
    
}

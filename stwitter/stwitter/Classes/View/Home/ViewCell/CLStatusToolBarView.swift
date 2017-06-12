//
//  CLStatusToolBarView.swift
//  stwitter
//
//  Created by sun on 2017/6/6.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLStatusToolBarView: UIView {
  
    var viewToorModel:CLStatusViewModel? {
        didSet{
            //转发
            retweetedBtn.setTitle(viewToorModel?.retweetedStr, for: .normal)
            
            //评论
            commentBtn.setTitle(viewToorModel?.commentStr, for: .normal)
            
            //评论
            likeBtn.setTitle(viewToorModel?.likeStr, for: .normal)
        }
    }
    
    
    /// 转发
    @IBOutlet weak var retweetedBtn: UIButton!
    
    /// 评论
    @IBOutlet weak var commentBtn: UIButton!
    
    /// 赞
    @IBOutlet weak var likeBtn: UIButton!
  

}

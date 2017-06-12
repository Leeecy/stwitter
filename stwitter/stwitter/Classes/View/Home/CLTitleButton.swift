//
//  CLTitleButton.swift
//  stwitter
//
//  Created by sun on 2017/5/31.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLTitleButton: UIButton {
     //重载构造函数 title 如果是nil 就显示“首页” 否则显示title 和箭头图像
    init(title:String?) {
        super.init(frame: CGRect())
        
        if title == nil {
            setTitle("首页", for: .normal)
        } else {
            
            setTitle(title!, for: .normal)
        }
        
        //默认 17 粗细
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
        //OC中不可以修改结构体中的值
        //Swift中可以直接修改
        titleLabel.frame.origin.x = 0
        imageView.frame.origin.x = titleLabel.bounds.width + 2.0
    }

}

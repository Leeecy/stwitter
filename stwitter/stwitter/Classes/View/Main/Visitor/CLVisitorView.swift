//
//  CLVisitorView.swift
//  stwitter
//
//  Created by sun on 2017/5/19.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLVisitorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 私有控件
    //懒加载属性 主要调用 UIkit 控件的在指定构造函数 其他都需要使用类型
    fileprivate lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    fileprivate lazy var houseIconView = UIImageView.init(image:#imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    fileprivate lazy var titleLabel:UILabel = UILabel.yw_label(withText: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    
    //注册按钮
    lazy var registerBtn: UIButton  = UIButton.yw_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    //登录按钮
    lazy var loginBtn: UIButton  = UIButton.yw_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    

}
extension CLVisitorView{

    func setupUI(){
        backgroundColor = UIColor.white
        
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(titleLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        titleLabel.textAlignment = .center
        
        //取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin:CGFloat = 20.0
    }
}

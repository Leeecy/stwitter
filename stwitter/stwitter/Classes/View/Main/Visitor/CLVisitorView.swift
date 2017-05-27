//
//  CLVisitorView.swift
//  stwitter
//
//  Created by sun on 2017/5/19.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit
import SnapKit

class CLVisitorView: UIView {
    
    
    //注册按钮
    lazy var registerBtn: UIButton  = UIButton.yw_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    //登录按钮
    lazy var loginBtn: UIButton  = UIButton.yw_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    var visitorInfo: [String:String]?{
        didSet{
            
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else{
                    
                    return
                    
            }
            
            titleLabel.text = message
            
            if imageName == "" {
                startAnimation()
                return
                
            }
            iconView.image = UIImage.init(named: imageName)
            
            maskIconView.isHidden = true
            houseIconView.isHidden = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfo(dict: [String:String]){
        
        
        
    }
    
    //旋转
    fileprivate func startAnimation(){
        let anim = CABasicAnimation.init(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        anim.isRemovedOnCompletion = false
        
        iconView.layer.add(anim, forKey: nil)
    }
    
    // MARK: - 私有控件
    //懒加载属性 主要调用 UIkit 控件的在指定构造函数 其他都需要使用类型
    fileprivate lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    fileprivate lazy var houseIconView = UIImageView.init(image:#imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    fileprivate lazy var titleLabel:UILabel = UILabel.yw_label(withText: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    
   
    //遮罩
    fileprivate lazy var maskIconView = UIImageView(image: UIImage(named:"visitordiscover_feed_mask_smallicon"))

}
extension CLVisitorView{

    func setupUI(){
        backgroundColor = UIColor.yw_color(withHex: 0xEDEDED)
//        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(maskIconView)
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
        iconView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
//            make.width.height.equalTo(80)
        }
        houseIconView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(margin)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(236)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.width.equalTo(100)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp.right)
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.width.equalTo(100)
        }
        maskIconView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(registerBtn.snp.top).offset(-margin)
        }
        
    }
}

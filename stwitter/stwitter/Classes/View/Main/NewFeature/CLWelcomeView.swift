//
//  CLWelcomeView.swift
//  stwitter
//
//  Created by sun on 2017/5/31.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit
import SDWebImage
class CLWelcomeView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.orange
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        guard let urlStr = CLNetworkManager.shared.userAccount.avatar_large,
            let url = URL(string: urlStr)
            else {
                return
        }
         iconView.sd_setImage(with: url, placeholderImage:  UIImage(named: "avatar_default_big"))
        
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
        
    }
    
    class func welcomeView() -> CLWelcomeView {
        let nib = UINib(nibName: "CLWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CLWelcomeView
        //从xib 加载的视图 默认 600* 600
        v.frame  = UIScreen.main.bounds
        return v
        
    }
    
    //视图被添加到window上，表示视图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layoutIfNeeded()
        bottomCons.constant = bounds.size.height - 200
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
        
    }

}

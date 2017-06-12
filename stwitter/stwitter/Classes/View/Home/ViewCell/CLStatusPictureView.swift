//
//  CLStatusPictureView.swift
//  stwitter
//
//  Created by sun on 2017/6/6.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit
import SDWebImage
class CLStatusPictureView: UIView {

     @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    
    var urls: [CLPictureModel]?{
        didSet{
            var index = 0
            
            
            for url in urls ?? [] {
                let iv = subviews[index] as!UIImageView
                
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                
                iv.yw_setImage(urlStr: url.thumbnail_pic, placeholderImage: UIImage(named: "paceholder"))
                index += 1
                
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        setupUI()
    }
}

extension CLStatusPictureView{
    fileprivate func setupUI(){
        backgroundColor = superview?.backgroundColor
        clipsToBounds = true
         let rect = CGRect(x: 0, y: pictureOutterMargin, width: CLStatusPictureItemWith, height: CLStatusPictureItemWith)
        let count = 3
        for i in 0..<9 {
            let row  = CGFloat(i / count)
            let col =  CGFloat(i % count)
            
            let iv = UIImageView.init(frame: rect)
            let xOffset = col * (CLStatusPictureItemWith + pictureInnerMargin)
            
            let yOffset = row * (CLStatusPictureItemWith + pictureInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            addSubview(iv)
            
            
        }
        
    }
}

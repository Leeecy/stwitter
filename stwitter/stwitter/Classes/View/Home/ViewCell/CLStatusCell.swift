//
//  CLStatusCell.swift
//  stwitter
//
//  Created by sun on 2017/6/1.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLStatusCell: UITableViewCell {
    
    /// 头像
    @IBOutlet weak var headIV: UIImageView!
    
    /// 姓名
    @IBOutlet weak var nameLab: UILabel!
    
    /// 会员图标
    @IBOutlet weak var memberIV: UIImageView!
    
    /// 时间
    @IBOutlet weak var timeLab: UILabel!
    
    /// 来源
    @IBOutlet weak var sourseLab: UILabel!
    
    /// 认证
    @IBOutlet weak var vipIV: UIImageView!
    
    /// 微博正文
    @IBOutlet weak var statusLab: FFLabel!
    
    @IBOutlet weak var tootBarView: CLStatusToolBarView!
    
    @IBOutlet weak var statusPictureView: CLStatusPictureView!
    
    @IBOutlet weak var retweetLabel: UILabel?

    var viewModel: CLStatusViewModel?{
        didSet{
            statusLab?.text =  viewModel?.status.text
            nameLab.text = viewModel?.status.user?.screen_name
            memberIV.image = viewModel?.memberIcon
            headIV.yw_setImage(urlStr: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage.init(named: "avatar_default_big"), isAvatar: true)
            tootBarView.viewToorModel = viewModel
            
            statusPictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            statusPictureView.urls = viewModel?.picUrls
            retweetLabel?.text = viewModel?.retweetText
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

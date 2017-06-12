//
//  CLNewFeatureView.swift
//  stwitter
//
//  Created by sun on 2017/5/31.
//  Copyright © 2017年 sun. All rights reserved.
//

import UIKit

class CLNewFeatureView: UIView {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterBtn: UIButton!

    @IBAction func enterBtn(_ sender: Any) {
        removeFromSuperview()
        
    }
    
    class func newFeatureView()-> CLNewFeatureView{
        let nib = UINib(nibName: "CLNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CLNewFeatureView
        //从xib 加载的视图 默认 600* 600
        v.frame  = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        //设置 scrollView 的属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        
        enterBtn.isHidden = true

    }


}
extension CLNewFeatureView:UIScrollViewDelegate{
    //滑动结束减速的时候调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        pageControl.currentPage = page
        if page == scrollView.subviews.count {
            removeFromSuperview()
        }
        enterBtn.isHidden = (page != scrollView.subviews.count - 1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        enterBtn.isHidden = true
        //计算当前是偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}

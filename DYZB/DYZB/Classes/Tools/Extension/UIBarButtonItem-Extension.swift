//
//  UIButtonIterm-Extension.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/23.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
//    class func createItem(ImageName: String,highlightedIamgeName:String,size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setBackgroundImage(UIImage(named: ImageName), for: .normal)
//        btn.setBackgroundImage(UIImage(named: highlightedIamgeName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return  UIBarButtonItem(customView: btn)
//    }
    convenience init(ImageName: String,highlightedIamgeName:String="",size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        if highlightedIamgeName != "" {
            btn.setBackgroundImage(UIImage(named: highlightedIamgeName), for: .highlighted)
        }
        if size == CGSize.zero {
             btn.sizeToFit()
        }else{
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init( customView: btn)
    }
}

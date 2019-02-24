//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/24.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

extension UIColor{

    convenience init(r: CGFloat, g: CGFloat,b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255, green: g/255, blue: b/255, alpha: alpha)
    }
}

//
//  MainviewController.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/23.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

class MainviewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyName:"Home")
        addChildVc(storyName:"Live")
        addChildVc(storyName:"Follow")
        addChildVc(storyName:"Profile")
        // Do any additional setup after loading the view.
    }

    private func addChildVc(storyName:String){
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVc作为子控制器
        addChildViewController(childVc)
    }
}

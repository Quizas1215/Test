//
//  HomeViewController.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/23.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
      
    }

 

}

//Mark- 设置UI界面
extension HomeViewController {
    private func setupUI(){
        //1.设置导航栏
        setupNavigationBar()
            
    }
    private func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let historytBtn  = UIButton()
        historytBtn.setBackgroundImage(UIImage(named: "Image_my_history"), for: .normal)
        historytBtn.setBackgroundImage(UIImage(named: "Image_my_history_clicked"), for: .highlighted)
        historytBtn.sizeToFit()
        let historyItem = UIBarButtonItem(customView: historytBtn)
        
        let searchtBtn  = UIButton()
        searchtBtn.setBackgroundImage(UIImage(named: "btn_search"), for: .normal)
        searchtBtn.setBackgroundImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
        searchtBtn.sizeToFit()
        let searchItem = UIBarButtonItem(customView: searchtBtn)
        
        let qrcodeBtn  = UIButton()
        qrcodeBtn.setBackgroundImage(UIImage(named: "Image_scan"), for: .normal)
        qrcodeBtn.setBackgroundImage(UIImage(named: "Image_scan_clicked"), for: .highlighted)
        qrcodeBtn.sizeToFit()
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
        
    }
    
}

//
//  HomeViewController.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/23.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit
private let  KTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    //懒加载属性
    private lazy var  pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavgationBarH, width: kScreenW, height: KTitleViewH)
        let titles = ["推荐","推荐","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        //titleView.backgroundColor = UIColor.purple
        return  titleView
    }()
    private lazy var pageContentView: PageContentView = {[weak self] in
        // 1.确定内容的Frame
        let ContentH =  kScreenH - kStatusBarH - kNavgationBarH - KTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + KTitleViewH, width: kScreenW, height: ContentH)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g:  CGFloat(arc4random_uniform(255)), b:  CGFloat(arc4random_uniform(255)), alpha: 1.0)
            childVcs.append(vc)
        }
        let ContentView =  PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        ContentView.delegate = self as! PageContentViewDelegate
        return ContentView
    }()
    
    
    // 系统回调用函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
      
    }
    
}

//Mark- 设置UI界面
extension HomeViewController {
    private func setupUI(){
        //0.
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
        setupNavigationBar()

        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
 
    }
    
    private func setupNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(ImageName: "logo")
        let size = CGSize(width: 30, height: 30)
        let historyItem = UIBarButtonItem(ImageName: "Image_my_history", highlightedIamgeName: "Image_my_history_clicked", size: size)
        let searchItem  = UIBarButtonItem(ImageName: "btn_search", highlightedIamgeName: "btn_search_clicked", size: size)
        let qrcodeItem  = UIBarButtonItem(ImageName: "Image_scan", highlightedIamgeName: "Image_scan_clicked", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)

//                let historytBtn  = UIButton()
//                historytBtn.setBackgroundImage(UIImage(named: "Image_my_history"), for: .normal)
//                historytBtn.setBackgroundImage(UIImage(named: "Image_my_history_clicked"), for: .highlighted)
//                historytBtn.frame = CGRect(origin: CGPoint.zero, size: size)
//                let historyItem = UIBarButtonItem(customView: historytBtn)
//
//
//                let searchtBtn  = UIButton()
//                searchtBtn.setBackgroundImage(UIImage(named: "btn_search"), for: .normal)
//                searchtBtn.setBackgroundImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
//                searchtBtn.frame = CGRect(origin:  CGPoint.zero, size: size)
//                let searchItem = UIBarButtonItem(customView: searchtBtn)
//
//                let qrcodeBtn  = UIButton()
//                qrcodeBtn.setBackgroundImage(UIImage(named: "Image_scan"), for: .normal)
//                qrcodeBtn.setBackgroundImage(UIImage(named: "Image_scan_clicked"), for: .highlighted)
//                qrcodeBtn.frame = CGRect(origin:  CGPoint.zero, size: size)
//                let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
    }
    
}
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex( currentIndex: index)
    }
}
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

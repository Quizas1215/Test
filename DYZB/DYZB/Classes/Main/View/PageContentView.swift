//
//  PageContentView.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/24.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //Mark: 定义属性
    private var childVcs: [UIViewController]
    private var parentViewController: UIViewController
    //Mark:懒加载属性
    private lazy var collectionView:UICollectionView = {
       	//1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建UICollectionView
        let CollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.isPagingEnabled = true
        CollectionView.bounces = false
        CollectionView.dataSource = self
        CollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return  CollectionView
    }()
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentViewController.addChildViewController(childVc)
        }
        //2.添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//Mark:遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //2.给Cell设置内容
        // 每次添加之前清楚掉原本的View 以减少出错 提高性能
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

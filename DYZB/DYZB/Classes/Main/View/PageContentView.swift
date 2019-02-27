//
//  PageContentView.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/24.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class{
    func pageContentView(contentView:PageContentView, progress:CGFloat, sourceIndex: Int, targetIndex: Int	)
}
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //Mark: 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    //Mark:懒加载属性
    private lazy var collectionView:UICollectionView = {[weak self] in
       	//1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建UICollectionView
        let CollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.isPagingEnabled = true
        CollectionView.bounces = false
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.scrollsToTop = false
        CollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return  CollectionView
    }()
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
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
            parentViewController?.addChildViewController(childVc)
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
//遵守UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        //2.判断是左滑右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        //左滑
        if currentOffsetX > startOffsetX {
            //计算progress
            progress = (currentOffsetX - startOffsetX) / scrollViewW
            //计算sourceIndex
            sourceIndex = Int(floor (startOffsetX / scrollViewW))
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
        }else {// 右滑
            print("hello")
            progress = (startOffsetX - currentOffsetX) / scrollViewW
            targetIndex =  Int(floor(currentOffsetX / scrollViewW))
            //计算targetIndex
            sourceIndex = targetIndex + 1
            
        }
        //3.将progress sourceIndex targetIndex
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        print("progress:\(progress)  sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        
    }
}
//对外暴露方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int ) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
    }
}

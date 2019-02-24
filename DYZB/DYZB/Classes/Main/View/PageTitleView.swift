//
//  PageTitleView.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/24.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit
private let KscrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    //定义属性
    private var titles: [String]
    
    //懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scroclView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.clipsToBounds = false
        
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
       let scrollLine = UIView()
       scrollLine.backgroundColor = UIColor.orange
       return scrollLine
    }()
    //自定义一个构造函数
    init(frame: CGRect, titles: [String]){
        self.titles = titles
        super.init(frame:frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Mark: = 设置UI界面
extension PageTitleView{
    private func setupUI(){
        //1.添加UIScrollview
        addSubview(scroclView)
        scroclView.frame = bounds
        //2.添加Title对应的Lable
        setupTitleLabels()
        //3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    private func setTitleLabels(){
        
    }
    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
      
        //2.获取第一个Label 添加scrollview的属性
        guard let firstLabel = titleLabels.first else { return }
        scroclView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KscrollLineH, width: firstLabel.frame.width, height: KscrollLineH)
        
    }
    
    private func setupTitleLabels(){
        //0.确定label的一些frame的值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - KscrollLineH
        let labelY: CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            //1.创建UILabel
            let label =    UILabel()
            //2.设置label的属性
            label.text = title
            label.tag  = index
            label.font = UIFont.systemFont(ofSize:16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置Label的Frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scroclView.addSubview(label)
            titleLabels.append(label)
            
        }
    }
}

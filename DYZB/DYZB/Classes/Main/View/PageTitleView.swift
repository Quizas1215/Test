//
//  PageTitleView.swift
//  DYZB
//
//  Created by 黄嘉懿 on 2019/2/24.
//  Copyright © 2019 黄嘉懿. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int)
}

private let KscrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    //定义属性
    private var currentIndex: Int = 0
    private var titles: [String]
    weak var delegate: PageTitleViewDelegate?
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

    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
      
        //2.获取第一个Label 添加scrollview的属性
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
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
            let label =   UILabel()
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
            //5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick))
            label.addGestureRecognizer(tapGes)
        }
    }
    

    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        //1.获取当前的Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        //3.切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        //4.保持最新Label的下标值
        currentIndex = currentLabel.tag
        //5.滚动条位置改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15){ self.scrollLine.frame.origin.x = scrollLineX }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

extension PageTitleView{
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        
    }
}

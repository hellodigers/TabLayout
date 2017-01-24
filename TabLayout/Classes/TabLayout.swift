//
//  TabLayout.swift
//  Pods
//
//  Created by Bartosz on 24.01.2017.
//
//

import UIKit

@objc public protocol TabLayoutDelegate: NSObjectProtocol {
    @objc optional func tabLayout(tabLayout: TabLayout, index: Int)
}

@IBDesignable public class TabLayout: UIScrollView, UIScrollViewDelegate{
    
    private let indicator = UIView()
    private var buttons = [UIButton]()
    private var controllers = [UIView]()
    
    private var index = 0
    private var previousIndex = 0
    
    @IBOutlet public weak var tabLayoutDelegate: TabLayoutDelegate!
    
    @IBOutlet public var scrollView: UIScrollView? {
        didSet {
            scrollView?.delegate = self
            scrollView?.showsHorizontalScrollIndicator = false
            scrollView?.isPagingEnabled = true
        }
    }
    
    @IBInspectable public var fixedMode: Bool = false {
        didSet { reload() }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.darkGray {
        didSet { reload() }
    }
    
    @IBInspectable public var currentTextColor: UIColor = UIColor.black {
        didSet { reload() }
    }
    
    @IBInspectable public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet { reload() }
    }
    
    @IBInspectable public var currentFont: UIFont = UIFont.boldSystemFont(ofSize: 12) {
        didSet { reload() }
    }
    
    @IBInspectable public var imageColor: UIColor = UIColor.darkGray {
        didSet { reload() }
    }
    
    @IBInspectable public var currentImageColor: UIColor = UIColor.black {
        didSet { reload() }
    }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.black {
        didSet { indicator.backgroundColor = indicatorColor }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        reload()
    }
    
    public func addTabs(tabs: [(title: String?, image: UIImage?, controller: UIViewController)]) {
        addTabButtons(tabs: tabs)
        addControllers(tabControllers: tabs.map { $0.controller })
        reload()
    }
    
    private func addControllers(tabControllers: [UIViewController]) {
        let scrollView = self.scrollView
        
        for view in (scrollView?.subviews)! {
            view.removeFromSuperview()
        }
        
        controllers = []
        
        for controller in tabControllers {
            scrollView?.addSubview(controller.view)
            controllers.append(controller.view)
        }
    }
    
    private func addTabButtons(tabs: [(title: String?, image: UIImage?, controller: UIViewController)]) {
        
        for button in buttons {
            button.removeFromSuperview()
        }
        
        buttons = []
        
        var i = 0
        for tab in tabs {
            let button = configButton(index: i, title: tab.title, image: tab.image)
            buttons.append(button)
            addSubview(button)
            addSubview(indicator)
            i += 1
        }
    }
    
    private func reload() {
        refreshButtons()
        if buttons.count > 0 {
            setIndex(index: index, animated: false, scroll: false)
        }
        scrollView?.contentSize = CGSize(width: (scrollView?.frame.size.width)! * CGFloat(buttons.count), height: (scrollView?.frame.size.height)!)
        
        for i in 0..<controllers.count {
            controllers[i].frame = CGRect(x: (scrollView?.frame.size.width)! * CGFloat(i), y: 0, width: (scrollView?.frame.size.width)!, height: (scrollView?.frame.size.height)!)
        }
    }
    
    private func refreshButtons() {
        let height = frame.size.height - 2
        var currentWidth : CGFloat = 0.0
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let width = buttonWidth(button: button)
            button.frame = CGRect(x: currentWidth, y: 0, width: width, height: height)
            currentWidth += width
            
            button.setTitleColor((i == index) ? currentTextColor : textColor, for: .normal)
            button.titleLabel?.font = (i == index) ? currentFont : font
            button.imageView?.tintColor = (i == index) ? currentImageColor : imageColor
        }
        
        contentSize = CGSize(width: currentWidth, height: height)
    }
    
    
    public func tabClicked(sender: UIButton) {
        tabLayoutDelegate?.tabLayout?(tabLayout: self, index: sender.tag)
        setIndex(index: sender.tag, animated: true, scroll: true)
    }
    
    public func setIndex(index: Int, animated: Bool, scroll: Bool) {
        self.index = index
        let button = self.buttons[index]
        
        var currentWidth : CGFloat = 0.0
        for i in 0...index {
            currentWidth += self.buttonWidth(button: self.buttons[i])
        }
        
        let width = self.buttonWidth(button: button)
        
        self.refreshButtons()
        
        self.indicator.frame = CGRect(x: currentWidth - width, y: self.frame.size.height - 2, width: width, height: 2)
        
        
        if index > previousIndex {
            scrollRectToVisible( CGRect(x: currentWidth, y: 0, width: 1, height: 1), animated: false)
        } else {
            if index != previousIndex {
                scrollRectToVisible( CGRect(x: currentWidth - width, y: 0, width: 1, height: 1), animated: false)
            }
        }
        
        previousIndex = index
        
        if scroll {
            self.scrollView?.contentOffset = CGPoint(x: CGFloat(index) * (scrollView?.frame.size.width)!, y: 0)
        }
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tab = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if tab != index {
            setIndex(index: tab, animated: true, scroll: false)
            tabLayoutDelegate?.tabLayout?(tabLayout: self, index: tab)
        }
        
    }
    
    public func buttonWidth(button: UIButton) -> CGFloat {
        var width : CGFloat = 0
        
        if fixedMode {
            width = self.frame.size.width / CGFloat(buttons.count)
            return width
        }
        
        let string = button.titleLabel?.text
        let font = button.titleLabel?.font
        let size = string?.size(attributes: [NSFontAttributeName: font!])
        let imageSize = button.imageView?.image?.size
        
        if size != nil {
            width =  (size?.width)! + 20
        }
        if imageSize != nil {
            width = width + (imageSize?.width)! + 20
        }
        
        
        return width
    }
}

extension TabLayout {
    public func configButton(index: Int, title: String?, image:UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.tag = index
        button.addTarget(self, action: #selector(TabLayout.tabClicked(sender:)), for: .touchUpInside)
        
        if title != nil {
            button.setTitle(title, for: .normal)
        }
        
        if image != nil {
            let img = image?.withRenderingMode(.alwaysTemplate)
            button.setImage(img, for: .normal)
            if title != nil {
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            }
        }
        
        return button
    }
}

//
//  UIStackView+Extension.swift
//  TestStackView
//
//  Created by kim on 2022/11/4.
//

import UIKit


extension UIStackView {
    /// 便利初始化方式
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0,
                     aligment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = aligment
        self.distribution = distribution
    }
    
    /// 添加子视图
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        for subview in arrangedSubviews {
            addArrangedSubview(subview)
        }
    }
    
    /// 添加子视图并设置约束
    func addArrangedSubviewsMakeConstraint(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
            view.makeConstraint()
        }
    }
    
    /// 移除子视图
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
    
    /// 生成一个指定间隔的填充区域
    func spacer(_ space: CGFloat) -> UIView {
        let spacer = UIView()
        switch axis {
        case .horizontal:
            spacer.widthConstraint = space
        case .vertical:
            spacer.heightConstraint = space
        default:
            break
        }
        return spacer
    }
    
    /// 生成一个填充区域
    func spacer() -> UIView {
        let spacer = UIView()
        return spacer
    }
    
    /// 生成一个弹簧 如果两边都使用弹簧，需要再将弹簧约束为等宽(高) 添加弹簧时distribution需要使用fill
    func spring() -> UIView {
        let spring = UIView()
        switch axis {
        case .horizontal:
            spring.makeWithConstraint(1000, priority: .defaultLow)
        case .vertical:
            spring.makeHeightConstraint(1000, priority: .defaultLow)
        default:
            break
        }
        return spring
    }
}

// MARK: HStack
class HStackView: UIStackView {
    convenience init(spacing: CGFloat = 0,
                     aligment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: [], axis: .horizontal, spacing: spacing, aligment: aligment, distribution: distribution)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 0
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: VStack
class VStackView: UIStackView {
    convenience init(spacing: CGFloat = 0,
                     aligment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: [], axis: .vertical, spacing: spacing, aligment: aligment, distribution: distribution)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 0
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private var widthConstraintKey = "widthConstraintKey"
private var heightConstraintKey = "heightConstraintKey"
private var sizeConstraintKey = "sizeConstraintKey"
private var widthConstraintIdentifier = "widthConstraintIdentifier"
private var heightConstraintIdentifier = "heightConstraintIdentifier"

// MARK: UIView支持StackView的扩展
extension UIView {
    /// 宽度约束
    var widthConstraint: CGFloat {
        get {
            return objc_getAssociatedObject(self, &widthConstraintKey) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &widthConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 高度约束
    var heightConstraint: CGFloat {
        get {
            return objc_getAssociatedObject(self, &heightConstraintKey) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &heightConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 尺寸约束
    var sizeConstraint: CGSize {
        get {
            return objc_getAssociatedObject(self, &sizeConstraintKey) as? CGSize ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &sizeConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置约束
    func makeConstraint() {
        if widthConstraint > 0 {
            makeWithConstraint(widthConstraint)
        }
        if heightConstraint > 0 {
            makeHeightConstraint(heightConstraint)
        }
        if sizeConstraint.width > 0 || sizeConstraint.height > 0 {
            makeWithConstraint(sizeConstraint.width)
            makeHeightConstraint(sizeConstraint.height)
        }
    }
    
    /// 更新约束
    func updateConstraint() {
        if sizeConstraint != .zero {
            widthConstraint = sizeConstraint.width
            heightConstraint = sizeConstraint.height
        }
        for constraint in self.constraints {
            if constraint.identifier == widthConstraintIdentifier {
                constraint.constant = widthConstraint
            } else if constraint.identifier == heightConstraintIdentifier {
                constraint.constant = heightConstraint
            }
        }
        self.updateConstraints()
    }
    
    func makeWithConstraint(_ width: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        constraint.priority = priority
        constraint.identifier = widthConstraintIdentifier
        NSLayoutConstraint.activate([constraint])
    }
    
    func makeHeightConstraint(_ height: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.priority = priority
        constraint.identifier = heightConstraintIdentifier
        NSLayoutConstraint.activate([constraint])
    }
}

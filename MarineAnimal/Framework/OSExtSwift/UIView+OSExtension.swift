//
//  UIView+Extension.swift
//  ExtSwift
//
//  Created by xu jie on 16/6/29.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit
extension UIView{
    // MARK:位置坐标
    var os_x:CGFloat{
        return self.frame.origin.x
    }
    var os_y:CGFloat{
        return self.frame.origin.y
    }
    var os_width:CGFloat{
        return self.frame.size.width
    }
    var os_height:CGFloat{
        return self.frame.size.height
    }
    // 设置视图圆角
    var os_cornerRadius:CGFloat{
        set{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }get{
            return 0
        }
    }
    // MARK:截屏程序
    func os_snapshotImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
       
        let  snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap!;
    }
    // MARK:截屏到转换为paf
   func os_snapshotPDF()-> NSData? {
        var  bounds = self.bounds
        let  data = NSMutableData()
        let  consumer = CGDataConsumer(data: data)
        let  context = CGContext(consumer: consumer!, mediaBox: &bounds, nil)
        if (context == nil){
            return nil
        }
        context!.beginPDFPage(nil);
        context!.translateBy(x: 0, y: bounds.size.height);
        context!.scaleBy(x: 1.0, y: -1.0);
        self.layer.render(in: context!)
        context!.endPDFPage();
        context!.closePDF();
        return data;
    }
    
    // MARK:在屏幕刷新后截屏
    func os_snapshotImageAfterScreenUpdates(afterUpdates:Bool)->UIImage{
        if self.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))){
            return self.os_snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates)
   
        let snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap!;
    }
    
    // MARK:设置视图阴影
    func os_setLayerShadow(color:UIColor,offset:CGSize,radius:CGFloat){
        self.layer.shadowColor = color.cgColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowRadius = radius;
        self.layer.shadowOpacity = 1;
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale;
    }
    
    // MARK: -移除所有子视图
    func os_removeAllSubviews(){
        while(self.subviews.count > 0){
            self.subviews.last!.removeFromSuperview()
        }
    }
    // MARK: - 获取视图所在的控制器
    func os_viewController() -> UIViewController?{
        var view:UIView? = self
        while(view != nil){
            let nextResponder = view?.next;
            if nextResponder is UIViewController{
                return nextResponder as? UIViewController
                
            }
            
            view = view?.superview
        }
        return nil;

    }
    /// 让视图转动
    func os_rotationWithRepeatCount(count:Int,duration:Double){
        let transform=CABasicAnimation(keyPath: "transform.rotation.z")
        transform.toValue = NSNumber(value: M_PI*2)
        transform.duration = duration
        transform.isRemovedOnCompletion = false
        transform.fillMode=kCAFillModeForwards;
        transform.repeatCount=100000;
        self.layer.add(transform, forKey: "Rotation")
    }
    /// 让视图停止转动
    func os_stopRotation(){
        self.layer.removeAllAnimations()
    }
    
    /// 使用xib 创建视图
    class func os_nibName(name:String) -> UIView? {
        guard let view = Bundle.main.loadNibNamed(name, owner: nil, options: [:])?.first as? UIView else {
            return nil
        }
        view.frame = UIScreen.main.bounds
        return view
        
    }
    ///
    func os_addblur(blur:CGFloat){
        
        if #available(iOS 8.0, *) {
            let effect = UIBlurEffect(style: .light)
            let effectView = UIVisualEffectView(effect:effect)
            effectView.frame = self.bounds
            effectView.alpha = blur
            self.addSubview(effectView)
        } else {
            let tool = UIToolbar(frame: self.bounds)
            tool.alpha = blur
            tool.barStyle = .blackTranslucent
            self.addSubview(tool)
        }
        
    }
   
    // 增加一个点击回调
     struct BlockContainerKey {
        static var key = "BlockContainerKey"
    }
    
    typealias GestureBlock = (_ gesture: UIGestureRecognizer?) -> Void
    typealias ControlBlock = (_ control: UIControl?) -> Void
    // 定义个一个Block容器
     class BlockContainer {
        var gestureBlock: GestureBlock?
        var controlBlock: ControlBlock?
    }
    // 定义个一个computed property，通过OC的运行时获取关联对象和设置关联对象
     var blockContainer: BlockContainer? {
        get {
            if let value = objc_getAssociatedObject(self, &BlockContainerKey.key) {
                return value as? BlockContainer
                
            }
            return nil
        }
        set (newValue){
            objc_setAssociatedObject(self, &BlockContainerKey.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    // 外部调用方法
    func os_addGestureBlock(block: @escaping GestureBlock) {
        if let _ = self as? UIControl {
            return
        } else {
            self.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(UIView.gestureAction(gesture:)))
            self.addGestureRecognizer(gesture)
            let blockContainer: BlockContainer = BlockContainer()
            blockContainer.gestureBlock = block
            self.blockContainer = blockContainer
            
        }
    }
    // 内部实现
    // 这里有一个问题，就是该方法无法用private修饰，因为当子类如UILabel调用的时候会崩溃
    func gestureAction(gesture:UITapGestureRecognizer) {
        guard (gesture.view === self) else {
            return
        }
        guard (self.blockContainer?.gestureBlock != nil) else {
            return
        }
        self.blockContainer!.gestureBlock!(gesture)
    }
    

}


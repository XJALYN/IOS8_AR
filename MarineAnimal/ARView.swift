//
//  ARSDK.swift
//  第四十二节 - AR的实现
//
//  Created by xu jie on 2017/4/23.
//  Copyright © 2017年 xujie. All rights reserved.
//
// 开发中请注意 如需系统学习SceneKit 请前往APPStore 搜索上架应用<SceneKit> 下载中文电子书进行学习

import UIKit
import SceneKit
import CoreMotion
import AVFoundation
class ARView: UIView,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ARViewProtocol{
   var session:AVCaptureSession!
   var previewLayer: AVCaptureVideoPreviewLayer!
   var output:AVCaptureMetadataOutput! //  重力感应
   var  motionManager = CMMotionManager()
  var orientation:UIInterfaceOrientation!
    var  scnView:SCNView = { // 游戏场景
        let view = SCNView()
        return view
    }()
    var  eyeNode:SCNNode = { // 眼睛节点
        let node = SCNNode()
        node.camera = SCNCamera()
        node.name = "camera"
        node.camera?.automaticallyAdjustsZRange = true;
        return node
    }()
    private func setup(){ // 初始化
        self.initCameraView()
        self.initScene()
        self.initMotionManger()
    }
    override init(frame: CGRect) {
     super.init(frame: frame)
     self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    private func initScene(){
        self.scnView.backgroundColor = UIColor.clear
        self.scnView.frame = UIScreen.main.bounds
        self.addSubview(self.scnView)
        self.scnView.scene = SCNScene()
        self.scnView.scene?.rootNode.addChildNode(self.eyeNode)
        
        //  增加一个手势改变模型的距离
    }
    
    
    private func initMotionManger(){
        motionManager.gyroUpdateInterval = 60;
        motionManager.deviceMotionUpdateInterval = 1/30.0
        motionManager.showsDeviceMovementDisplay = true
        motionManager.startDeviceMotionUpdates(using: .xTrueNorthZVertical, to: OperationQueue.main) { (motion, error) in
            if  let attitude = motion?.attitude,error == nil{
                var vector = SCNVector3Zero
                if (UIDevice.current.orientation.isPortrait) // home键靠右
                {
                    vector.x = Float(attitude.pitch);
                    vector.y = (Float)(attitude.roll);
                }else if(UIDevice.current.orientation.isLandscape ){
                    vector.x = (Float)(attitude.pitch);
                    vector.y = Float(attitude.roll);
                }else{
                    vector.x = (Float)(attitude.pitch)
                    vector.y = Float(attitude.roll);
                }
                vector.z = Float(attitude.yaw);
                self.eyeNode.eulerAngles = vector
            }
        }
    }
    
    func initCameraView(){
      let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
      let input = try! AVCaptureDeviceInput(device: device)
      output = AVCaptureMetadataOutput()
      output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      session = AVCaptureSession()
      session.canSetSessionPreset(AVCaptureSessionPresetHigh)
       if(session.canAddInput(input)){
           session.addInput(input)
        }
        if(session.canAddOutput(output)){
           session.addOutput(output)
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = UIScreen.main.bounds
        self.layer.addSublayer(previewLayer!)
        session.startRunning()
    }
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {}
    
    
    func addModelFile(file:URL,position:SCNVector3){
       let scene = try! SCNScene(url: file, options: nil)
       let node = scene.rootNode.clone()
       node.position = position
       self.scnView.scene?.rootNode.addChildNode(node)
    }
    func showModel(node: SCNNode,position:SCNVector3){
         if  let nodes =   self.scnView.scene?.rootNode.childNodes {
            for node in nodes {
                if(node.name != "camera"){
                    
                     node.removeFromParentNode()
                }
                
            }
        }
        
        
        let newNode = node.clone()
        newNode.position = position
        newNode.pivot = SCNMatrix4Rotate(newNode.pivot, Float.pi/2.0, 0, 1, 0)
        newNode.pivot = SCNMatrix4Rotate(newNode.pivot, Float.pi/2.0, 0, 0, 1)
        self.scnView.scene?.rootNode.addChildNode(newNode)
    }
    deinit {
       session.stopRunning()
    }
}
    
    




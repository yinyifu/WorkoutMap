//
//  SessionController.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 10/4/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class WatchSessionController: WKInterfaceController, WCSessionDelegate{
    @IBOutlet weak var myImage: WKInterfaceImage!
    //@IBOutlet var touch_to_change_image: WKInterfaceButton!
    override init(){
        self.ed = ExtensionDelegate();
        super.init();
    }
    var error_error = [
        "error" : "error: can not find picture."
    ]
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {}
    var ed : ExtensionDelegate;
    /*@IBAction func sendAction() {
        if let image: UIImage = UIImage(named:"Ls.jpg"){
            change_Image(newImage: image);
            WCSession.default.sendMessage(error_error, replyHandler: { (data) -> Void in}) { (error) -> Void in
                exit(0);
            }
        }else{
            WCSession.default.sendMessage(error_error, replyHandler: { (data) -> Void in}) { (error) -> Void in
                exit(0);
            }
        }
        
    }
    */
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
        guard let image = UIImage(data: messageData as Data) else {
            return
        }
        
        // throw to the main queue to upate properly
        DispatchQueue.main.async() { [weak self] in
            self?.change_Image(newImage: image)
        }
        
        replyHandler(messageData)
    }
    /*
    func resize(_ image: CGImage) -> CGImage? {
        var ratio: Float = 0.0
        let imageWidth = Float(image.width)
        let imageHeight = Float(image.height)
        let maxWidth: Float = self.
        let maxHeight: Float = 20
        
        // Get ratio (landscape or portrait)
        if (imageWidth > imageHeight) {
            ratio = maxWidth / imageWidth
        } else {
            ratio = maxHeight / imageHeight
        }
        
        // Calculate new size based on the ratio
        if ratio > 1 {
            ratio = 1
        }
        
        let width = imageWidth * ratio
        let height = imageHeight * ratio
        
        guard let colorSpace = image.colorSpace else { return nil }
        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: image.bitsPerComponent, bytesPerRow: image.bytesPerRow, space: colorSpace, bitmapInfo: image.alphaInfo.rawValue) else { return nil }
        
        // draw image to context (resizing it)
        context.interpolationQuality = .high
        context.draw(image, in: CGRect(x: 0, y: 0, width: Int(width), height: Int(height)))
        // extract resulting image from context
        return context.makeImage()
    }
    */
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        
        guard let image = UIImage(data: messageData as Data) else {
            return
        }
        
        // throw to the main queue to upate properly
        DispatchQueue.main.async() { [weak self] in
            self?.change_Image(newImage: image)
        }
        
        replyHandler(messageData)
    }
    func change_Image(newImage : UIImage){
        /*
        let ifmage = newImage.cgImage {
            let image = resize(ifmage);
          */  myImage.setImage(newImage);
        myImage.setWidth(500)
        
        myImage.sizeToFitHeight()
        //}
    }
}


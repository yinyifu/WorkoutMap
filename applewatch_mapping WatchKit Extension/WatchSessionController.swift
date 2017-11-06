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
import UIKit
import CoreGraphics

class WatchSessionController: WKInterfaceController, WCSessionDelegate{
    @IBOutlet weak var myImage: WKInterfaceImage!
    //@IBOutlet var touch_to_change_image: WKInterfaceButton!
    var previousData : UIImage?;
    override init(){
        self.ed = ExtensionDelegate();
        super.init();
    }
    
    var dateBrrr : NSDate?;
    var error_error = [
        "error" : "error: can not find picture."
    ]
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {}
    var ed : ExtensionDelegate;
    
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
    var counter = 0;
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
        
        guard let image = UIImage(data: messageData) else {
            if let imagew = previousData{
                self.myImage.setImage(imagew)
            }
            return
        }
        
        guard image.size.width > 50 && image.size.height > 50 else{
            return
        }
        
        guard !image.isEqual(image.flipsForRightToLeftLayoutDirection) else{
            return
        }
        guard let cgi = image.cgImage else{
            return
        }
        guard cgi.colorSpace != nil else{
            return
        }
        guard !imageIsWhite(image) else{
            return
        }
        guard !CGSize.init(width: 0, height: 0).equalTo(image.size) else{
            return
        }
        // throw to the main queue to upate properly
        
        self.myImage.setImage(image)
        self.previousData = image
        replyHandler(messageData)
    }
    func imageIsWhite(_ img: UIImage) -> Bool {
        let imageRef = img.cgImage
        let data = imageRef!.dataProvider!.data! as Data
        let pixels : [UInt8] = [UInt8](data)
        var isWhite = true
        var i = 0
        while i < data.count {
            if !(UInt8(pixels[i]) > UInt8(220) && UInt8(pixels[i + 1]) > UInt8(220) && UInt8(pixels[i + 2]) > UInt8(220) && UInt8(pixels[i + 3]) > UInt8(220)) {
                isWhite = false
                break
            }
            i += 4
        }
        return isWhite
    }

/*
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        
        guard let image = UIImage(data: messageData as Data) else {
            if let image = previousData{
                
                
            }
            return
        }
        guard image.size.width > 50 && image.size.height > 50 else{
            return
        }
        guard !image.isEqual(image.flipsForRightToLeftLayoutDirection) else{
            return
        }
        
        
        // throw to the main queue to upate properly
        self.change_Image(newImage: image)
        replyHandler(messageData)
    }
    */
    func change_Image(newImage : UIImage){
        myImage.setImage(newImage);
    }
}


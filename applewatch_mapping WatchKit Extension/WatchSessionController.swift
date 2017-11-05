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
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
        let nswatch = NSDate();
        if let datebr = dateBrrr{
            if nswatch.compare(datebr as Date).rawValue <= 0{
                replyHandler(messageData)
                return
            }
        }else{
            dateBrrr = NSDate().addingTimeInterval(3);
        }
        
        guard let image = UIImage(data: messageData as Data) else {
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
        guard let cs = cgi.colorSpace else{
            return
        }
        guard cs.colorTable![0] != UINT8_MAX else{
            return
        }
        // throw to the main queue to upate properly
        
        self.myImage.setImage(image)
        replyHandler(messageData)
    }
/*
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        
        guard let image = UIImage(data: messageData as Data) else {
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


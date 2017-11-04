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
        myImage.setImage(newImage);
        myImage.setWidth(500)
        
        myImage.sizeToFitHeight()
        //}
    }
}


//
//  WCSessionDelegate.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 10/4/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation
import WatchConnectivity
import UIKit
class SessionController : NSObject, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        NSLog(message["error"] as! String);
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        NSLog("i chose this one");
        replyHandler(message);
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        NSLog("received data");
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        NSLog("received data with handler");
    }
    override init(){
        super.init();
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate=self
            session.activate()
        }
    }
    func send_image(_ image : UIImage){
        NSLog("The image is generated");
        if let data = UIImageJPEGRepresentation(image, 1.0){
            if(WCSession.default.isPaired){
                if(WCSession.default.isWatchAppInstalled){
                    
                    
                    WCSession.default.sendMessageData(data, replyHandler: { (data) -> Void in}){ (error) -> Void in
                        print("error: \(error.localizedDescription)");
                    }
                } else{
                    NSLog("error: watch app not installed");
                }
            }else{
                NSLog("error: you are not paired");
            }
        }
    }
}

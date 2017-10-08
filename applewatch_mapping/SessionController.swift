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
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    override init(){
        super.init();
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate=self
            session.activate()
        }
        let image_name :String = "Ls.jpg";
        NSLog("The image is about to be generated\n");
        if let image = UIImage(named : "Ls.jpg") {
           NSLog("The image is generated");
            if let data = UIImageJPEGRepresentation(image, 1.0){
            
                WCSession.default.sendMessageData(data, replyHandler: { (data) -> Void in}) { (error) -> Void in
                    print("error: \(error.localizedDescription)");
                }
            }
        }else{
            NSLog("error: The image cant be found");
        }
        
       
    }
    
}

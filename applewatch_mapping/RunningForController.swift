//
//  ViewController.swift
//  applewatch_mapping
//
//  Created by yifu on 9/6/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces

//@interface MyLocationViewController : UIViewController <CLLocationManagerDelegate>

class RunningForController: UIViewController {
    let _sc : SessionController = SessionController();
    private var mapController : MapController?;
    
    let range = 10
    var mila : Int = 0;
    
    @IBAction func AddARoute(_ sender: Any) {
        changeMinutes();
        
        
    }
    @IBAction func well(_ sender: Any) {
        if let mc = self.mapController{
            if let ul = mc.getPerson(){
                mc.setCenter(ul);
                mc.setFollowing(true);
            }
        }
    }
    func routooooooooo(){
        guard self.mila > 0 else{
            return
        }
        
        if let control = self.mapController{
            guard let ps = control.getPerson() else{
                alerting(title: "Direction service is not on", message: "Please turn it on in Setting->applewatch_map->Location Service")
                return
            }
            let center = ps;
            let auticticnumber = 200;
            let latitudeChange = Float(arc4random()) / Float(UINT32_MAX)*Float(self.mila)/Float(auticticnumber)-Float(self.mila)/Float(auticticnumber)
            
            let longtitude = (Float(self.mila*self.mila)/Float(auticticnumber)/Float(auticticnumber))
            let longtitudeChange = (longtitude - latitudeChange*latitudeChange)
            var change = longtitudeChange.squareRoot()
            if Float(arc4random()) / Float(UINT32_MAX) > 0.5{
                change = -change
            }
            control.routeToDots( CLLocationCoordinate2DMake(center.latitude+Double(latitudeChange), center.longitude+Double(change)), "Your Target")
            
        }else{
            NSLog("afraid");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapController,
            segue.identifier == "runSegue" {
            self.mapController = vc
            DispatchQueue.main.async {
                sleep(2)
                vc.send_an_image()
            }
        }else{
            NSLog("Can not find subview segue MapController from Running Tab");
        }
    }
    
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeMinutes() {
            let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.actionSheet)
        
            self.mila = 0;
            
            let Mile1Action = UIAlertAction(title: "1 Miles", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.mila = 1
                self.routooooooooo()
            }
            
            let Mile2Action = UIAlertAction(title: "2 Miles", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.mila = 2
                self.routooooooooo()
                    }
            let Mile4Action = UIAlertAction(title: "4 Miles", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.mila = 4
                self.routooooooooo()
            }
            let Mile7Action = UIAlertAction(title: "7 Miles", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.mila = 7
                self.routooooooooo()
            }
            let Mile10Action = UIAlertAction(title: "10 Miles", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.mila = 10
                self.routooooooooo()
            }
            let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
                
            }
            
            actionSheet.addAction(Mile1Action)
             actionSheet.addAction(Mile2Action)
             actionSheet.addAction(Mile4Action)
             actionSheet.addAction(Mile7Action)
             actionSheet.addAction(Mile10Action)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
        }
    //trying to make uiimage
    @objc func getLoc(sender: UIButton, event: UIEvent){
        
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200));
        let image :UIImage? = UIGraphicsGetImageFromCurrentImageContext();
        if let img = image{
            _sc.send_image(img)
        }else{
            NSLog("UIGraphic image did not generate")
        }
    }
    
}



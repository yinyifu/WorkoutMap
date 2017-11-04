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
    
    @IBAction func AddARoute(_ sender: Any) {
        if let control = self.mapController{
            let center = control.getCenter();
            let coordA = CLLocationCoordinate2DMake(center.latitude , center.longitude+0.005)
            let coordB = CLLocationCoordinate2DMake(center.latitude+0.004 , center.longitude+0.008)
            let coordC = CLLocationCoordinate2DMake(center.latitude+0.007 , center.longitude)
            let coordD = CLLocationCoordinate2DMake(center.latitude , center.longitude)
            
            control.addARoutes([coordA, coordB, coordC, coordD])
            
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
        }else{
            NSLog("Motherfucker didnt prepare");
        }
        
    }
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //trying to make uiimage
    @objc func getLoc(sender: UIButton, event: UIEvent){
        
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200));
        let image :UIImage? = UIGraphicsGetImageFromCurrentImageContext();
        if let img = image{
            _sc.send_image(img)
        }else{
            NSLog("mother UIGraphic get image is hard to use Mother")
        }
    }
}



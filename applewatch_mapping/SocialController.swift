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

class SocialController: UIViewController {
    let _sc : SessionController = SessionController();
    private var mapController : MapController?;
    
    let range = 10
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapController,
            segue.identifier == "socialSegue" {
            self.mapController = vc
        }else{
            NSLog("Can not find subview segue MapController from Social tab.");
        }
    }
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //trying to make uiimage
    @objc func getLoc(sender: UIButton, event: UIEvent){
        //_sc.send_image()
    }
}

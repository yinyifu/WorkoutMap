//
//  LocationManagerController.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 10/4/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation
import CoreLocation
import WatchConnectivity
import GoogleMaps

class LocationManagerController : NSObject, CLLocationManagerDelegate{
    var _mapview : MapController?;
    let _square_window : Double = 0.001
    let cm = CLLocationManager();
    
    init(mapController mc:MapController){
        super.init()
        self._mapview = mc;
        if(!CLLocationManager.locationServicesEnabled()) {
            print("error mother fuckboy not enabled")
        }
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.cm.requestWhenInUseAuthorization()
        }
        if((CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways )||(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse)){
            cm.desiredAccuracy = kCLLocationAccuracyBest;
            cm.delegate = self
            cm.startUpdatingLocation()
        }else if (CLLocationManager.authorizationStatus() == .denied){
            self.alerting(title: "You have denied GPS", message: "Go to setting -> applewatch_mapping and change the location setting to always or when using the app.")
            NSLog("error mother you deny me i deny you hehehe");
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let use = locations.last{
            if let map = self._mapview{
                map.setCenter(use.coordinate);
                map.routing_Update();
                map.send_an_image();
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        NSLog("dick mother");
    }
    
    func didChangeValue<Value>(for keyPath: KeyPath<LocationManagerController, Value>) {
        NSLog("asdffdsa");
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription);
    }
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        NSLog("asdf");
    }
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self._mapview!.present(alert, animated: true, completion: nil)
    }
    
}

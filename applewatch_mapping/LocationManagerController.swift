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
    var _mapview : GMSMapView?;
    let _square_window : Double = 0.001
    let cm = CLLocationManager();
    init(mapview:GMSMapView){
        super.init()
        self._mapview = mapview;
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
            NSLog("error motherfucker");
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let use = locations.last{
            if let map = self._mapview{
                map.camera = GMSCameraPosition.camera(withLatitude: use.coordinate.latitude, longitude: use.coordinate.longitude, zoom: 16.0);
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        NSLog("dick mother")
    }
    
    func didChangeValue<Value>(for keyPath: KeyPath<LocationManagerController, Value>) {
        NSLog("asdffdsa")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        NSLog("asdf")
    }
    
}

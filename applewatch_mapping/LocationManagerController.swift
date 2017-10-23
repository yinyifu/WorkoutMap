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
    var _mapview : GMSMapView;
    let _square_window : Double = 0.001
    init(mapview:GMSMapView){
        self._mapview = mapview;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let use = locations.last{
            self._mapview.camera = GMSCameraPosition.camera(withLatitude: use.coordinate.latitude, longitude: use.coordinate.longitude, zoom: 1.0);
        }
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

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
import MapKit

class LocationManagerController : NSObject, CLLocationManagerDelegate, locationDelegate{
    var _mapview : MKMapView?;
    func onUserLocationChange() {
        // do the ui update
        
        
        
        
        // do the watch communication
    }
    
    func onUserChosenLocationChange() {
        //update route thing
        
        // ^
    }
    
    func onUserDirectionLocationChange() {
        
    }
    
    override init(){
        super.init();
    }
    init(mapview:MKMapView){
        self._mapview = mapview;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        NSLog("asdffdsa")
    }
    
    
}

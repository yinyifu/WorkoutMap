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
    let _square_window : Double = 0.001
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
        if let use = locations.last{
            
            self._mapview?.setRegion(MKCoordinateRegion(center: use.coordinate, span: MKCoordinateSpan(latitudeDelta: _square_window, longitudeDelta: _square_window )), animated: true)
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

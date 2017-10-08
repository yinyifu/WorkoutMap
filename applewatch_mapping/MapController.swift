//
//  MapController.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 9/8/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit
enum LocationException:Error{
    case authorizationDenied
    case authorizationRestricted
    case authorizationUndetermined
}
class MapController:NSObject, MKMapViewDelegate{

    
    /*************************
     *  */
    

    /*************************/
    var userloc : CLLocation? = nil;
    let locationMan = CLLocationManager();
  
    override init (){
        super.init();
        locationMan.requestAlwaysAuthorization();
        locationMan.startMonitoringSignificantLocationChanges()
        
    }
    
    func getUserCurrentLocation() throws  -> CLLocation?
    {
        let authorize:CLAuthorizationStatus = CLLocationManager.authorizationStatus() ;
        
        guard authorize != CLAuthorizationStatus.restricted else{
            throw LocationException.authorizationRestricted
        }
        guard authorize != CLAuthorizationStatus.denied else{
            throw LocationException.authorizationDenied
        }
        guard authorize != CLAuthorizationStatus.notDetermined else{
            throw LocationException.authorizationUndetermined
        }
        
        return locationMan.location;
    }
    /*
    func showSuggestions (input : NSString) -> NSArray<NSString>{}
    func searchUserDestination(input : NSString) -> NSArray<CLLocation>{}
    func routingBetweenLocations(from : CLLocation, to : CLLocatios) -> NSObject?{}
    func getLocationDescriptions (place : CLLocation)->NSString{}
    func sendDataToWatch(watch/*: watch?*/){}
    func retreveDataFromWatch(watch) -> NSString{}
    func ifDirectionChange(/*routing data*/)->Bool{}
    func directionChange(/*routing data*/) /* -> direction data */{    }
}*/
}

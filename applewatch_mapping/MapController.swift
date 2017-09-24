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
enum LocationException:Error{
    case noLocationStatus
    case authorizationDenied
    case authorizationRestricted
    case authorizationUndetermined
}
class MapController{

    
    /*************************
     *  */
    

    /*************************/
    var userloc : CLLocation? = nil;
    let locationMan = CLLocationManager();
    init(){
        
        locationMan.requestWhenInUseAuthorization();
    }
    
    
    func getUserCurrentLocation() throws  -> CLLocation?
    {
        guard let authorize:CLAuthorizationStatus = CLLocationManager.authorizationStatus() else {
            throw LocationException.noLocationStatus;
        }
        
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
    func showSuggestions (input : NSString) -> NSArray<NSString>
    {
        
    }
    
    func searchUserDestination(input : NSString) -> NSArray<CLLocation>
    {
    
    }
    
    func routingBetweenLocations(from : CLLocation, to : CLLocatios) -> NSObject?
    {
    
    }
    
    func getLocationDescriptions (place : CLLocation)->NSString
    {
    
    }
    
    func sendDataToWatch(watch/*: watch?*/)
    {
    
    }

    func retreveDataFromWatch(watch) -> NSString
    {
        
    }
    
    func ifDirectionChange(/*routing data*/)->Bool
    {
    }
    
    func directionChange(/*routing data*/) /* -> direction data */{
        
    }

}*/
}

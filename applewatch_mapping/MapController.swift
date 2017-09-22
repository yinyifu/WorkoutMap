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

class MapController{

    
    /*************************
     *  */
    
    /*************************/
    var userloc : CLLocation? = nil;
    let CLLocationMan = CLLocationManager();
    init(){
        
        CLLocationMan.requestWhenInUseAuthorization();
    }
    
    
    func getUserCurrentLocation() -> CLLocation?
    {
        CLLocationManager.authorizationStatus();
        return CLLocationMan.location;
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
    
    func directionChange(/*routing data*/) /* -> direction data         */{
        
    }
     */
}


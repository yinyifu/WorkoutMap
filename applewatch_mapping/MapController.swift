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
/*
class MapController : CLLocationManagerDelegate{

    
    /*************************
     *   Reference: https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
     */
    let locationManager = CLLocationManager()
     func MapConInit(){
         self.locationManager.requestAlwaysAuthorization()
         self.locationManager.requestWhenInUseAuthorization()
         if(CLLocationManager.locationServicesEnabled()){
             locationManager.delegate = self
             locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
             locationManager.startUpdatingLocation()
         }
     }
    /*************************/
   
    func getUserCurrentLocation() -> CLLocation
    {
        
        return locationManager.location.coordinate;
    }
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
}*/

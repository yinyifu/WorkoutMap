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
    case locationServiceNotEnabled
    case mapViewNotSet
    case locDelNotSet
}
class MapController:NSObject, MKMapViewDelegate{

    
    /*************************
     *  */
    

    /*************************/
    var userloc : CLLocation? = nil;
    let locationMan = CLLocationManager();
    var _locationDelegate :LocationManagerController?;
    weak var _mapview:MKMapView?;
    override init (){
        super.init();
        locationMan.requestAlwaysAuthorization();
        locationMan.startMonitoringSignificantLocationChanges()
    }
    
    func map_prepare(mapview:MKMapView){
        self._mapview = mapview
        self._locationDelegate = LocationManagerController(mapview: mapview);
    }
    
    func add_loc_del(loc_del:LocationManagerController){
        self._locationDelegate = loc_del
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
        guard CLLocationManager.locationServicesEnabled() == true else{
            throw LocationException.locationServiceNotEnabled;
        }
        
        return locationMan.location;
    }
    func startGettingLocations() throws
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
        guard CLLocationManager.locationServicesEnabled() == true else{
            throw LocationException.locationServiceNotEnabled;
        }
        guard self._mapview != nil else{
            throw LocationException.mapViewNotSet;
        }
        guard self._locationDelegate != nil else{
            throw LocationException.locDelNotSet;
        }
        
        locationMan.delegate = self._locationDelegate;
        locationMan.startUpdatingLocation()
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

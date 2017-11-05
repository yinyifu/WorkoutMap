//
//  mapTasks.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 11/4/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import CoreLocation
/*credit : https://www.appcoda.com/google-maps-api-tutorial/ */
class mapTasksLib : NSObject{
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    var fetchedFormattedAddress: String!
    var fetchedAddressLongitude: Double!
    var fetchedAddressLatitude: Double!
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    var selectedRoute: Dictionary<String, AnyObject>!
    
    var overviewPolyline: Dictionary<String, AnyObject>!
    
    var originCoordinate: CLLocationCoordinate2D!
    
    var destinationCoordinate: CLLocationCoordinate2D!
    
    var originAddress: String!
    
    var destinationAddress: String!
    
    
    var totalDistanceInMeters: UInt = 0
    
    var totalDistance: String!
    
    var totalDurationInSeconds: UInt = 0
    
    var totalDuration: String!
    let directionApi : String = "AIzaSyAaUoTiXpxA5jF6ik8yPgowKbnUtVtcxYQ";
    
    
    override init() {
        super.init()
    }
    
    func getDirections234(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D, _ endaddressname : String, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(coord1.latitude),\(coord1.longitude)&destination=\(coord2.latitude),\(coord2.longitude)&mode=walking&key=\(self.directionApi)";
        print(urlString);
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler:{ data, response, error in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let directionsData = data else {
                print("Error: did not receive data")
                return
            }
            do{
                let dictionary: Dictionary<String, AnyObject> = try JSONSerialization.jsonObject(with: directionsData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                
                let status = dictionary["status"] as! String
                if status == "OK" {
                    self.selectedRoute = (dictionary["routes"] as! Array<Dictionary<String, AnyObject>>)[0]
                    self.overviewPolyline = self.selectedRoute["overview_polyline"] as! Dictionary<String, AnyObject>
                    
                    let legs = self.selectedRoute["legs"] as! Array<Dictionary<String, AnyObject>>
                    
                    let startLocationDictionary = legs[0]["start_location"] as! Dictionary<String, AnyObject>
                    self.originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat"] as! Double, startLocationDictionary["lng"] as! Double)
                    
                    let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<String, AnyObject>
                    self.destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat"] as! Double, endLocationDictionary["lng"] as! Double)
                    
                    self.originAddress = legs[0]["start_address"] as! String
                    if(legs.count == 0){
                        print("why is there 0 legs")
                    }
                    self.destinationAddress = endaddressname
                    
                    self.calculateTotalDistanceAndDuration()
                    
                    completionHandler(status, true)
                }
                else {
                    completionHandler(status, false)
                }
            } catch {
                print(error)
                completionHandler("", false)
                return
            }
        })
        task.resume()
    }
    /*
    func getDirections222(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
            var directionsURLString = baseURLDirections + "origin=\(origin.latitude),\(origin.longitude)&destination=\(origin.latitude),\(origin.longitude)&mode=walking&key=\(self.directionApi)"
            directionsURLString = directionsURLString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let directionsURL = NSURL(string: directionsURLString)
            DispatchQueue.main.async {
                let directionsData = NSData(contentsOf: directionsURL! as URL)
                
                do{
                    let dictionary: Dictionary<NSObject, AnyObject> = try JSONSerialization.jsonObject(with: directionsData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<NSObject, AnyObject>
                    
                    let status = dictionary["status" as NSObject] as! String
                    if status == "OK" {
                        self.selectedRoute = (dictionary["routes" as NSObject] as! Array<Dictionary<NSObject, AnyObject>>)[0]
                        self.overviewPolyline = self.selectedRoute["overview_polyline" as NSObject] as! Dictionary<NSObject, AnyObject>
                        
                        let legs = self.selectedRoute["legs" as NSObject] as! Array<Dictionary<NSObject, AnyObject>>
                        
                        let startLocationDictionary = legs[0]["start_location" as NSObject] as! Dictionary<NSObject, AnyObject>
                        self.originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat" as NSObject] as! Double, startLocationDictionary["lng" as NSObject] as! Double)
                        
                        let endLocationDictionary = legs[legs.count - 1]["end_location" as NSObject] as! Dictionary<NSObject, AnyObject>
                        self.destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat" as NSObject] as! Double, endLocationDictionary["lng" as NSObject] as! Double)
                        
                        self.originAddress = legs[0]["start_address" as NSObject] as! String
                        self.destinationAddress = legs[legs.count - 1]["end_address" as NSObject] as! String
                        
                        self.calculateTotalDistanceAndDuration()
                        
                        completionHandler(status, true)
                    }
                    else {
                        completionHandler(status, false)
                    }
                } catch {
                    print(error)
                    completionHandler("", false)
                    return
                }
                
            }
        }
        
    
    
    
    
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
                directionsURLString = directionsURLString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let directionsURL = NSURL(string: directionsURLString)
                DispatchQueue.main.async {
                    let directionsData = NSData(contentsOf: directionsURL! as URL)
                    
                    do{
                        let dictionary: Dictionary<NSObject, AnyObject> = try JSONSerialization.jsonObject(with: directionsData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<NSObject, AnyObject>
                        
                        let status = dictionary["status" as NSObject] as! String
                        if status == "OK" {
                            self.selectedRoute = (dictionary["routes" as NSObject] as! Array<Dictionary<NSObject, AnyObject>>)[0]
                            self.overviewPolyline = self.selectedRoute["overview_polyline" as NSObject] as! Dictionary<NSObject, AnyObject>
                            
                            let legs = self.selectedRoute["legs" as NSObject] as! Array<Dictionary<NSObject, AnyObject>>
                            
                            let startLocationDictionary = legs[0]["start_location" as NSObject] as! Dictionary<NSObject, AnyObject>
                            self.originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat" as NSObject] as! Double, startLocationDictionary["lng" as NSObject] as! Double)
                            
                            let endLocationDictionary = legs[legs.count - 1]["end_location" as NSObject] as! Dictionary<NSObject, AnyObject>
                            self.destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat" as NSObject] as! Double, endLocationDictionary["lng" as NSObject] as! Double)
                            
                            self.originAddress = legs[0]["start_address" as NSObject] as! String
                            self.destinationAddress = legs[legs.count - 1]["end_address" as NSObject] as! String
                            
                            self.calculateTotalDistanceAndDuration()
                            
                            completionHandler(status, true)
                        }
                        else {
                            completionHandler(status, false)
                        }
                    } catch {
                        print(error)
                        completionHandler("", false)
                        return
                    }
                    
                }
            }
            else {
                completionHandler("Destination is nil.", false)
            }
        }
        else {
            completionHandler("Origin is nil", false)
        }
       
    }
 */
    func calculateTotalDistanceAndDuration() {
        let legs = self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>>
        
        totalDistanceInMeters = 0
        totalDurationInSeconds = 0
        
        for leg in legs {
            totalDistanceInMeters += (leg["distance" as NSObject] as! Dictionary<NSObject, AnyObject>)["value" as NSObject] as! UInt
            totalDurationInSeconds += (leg["duration" as NSObject] as! Dictionary<NSObject, AnyObject>)["value" as NSObject] as! UInt
        }
        
        
        let distanceInKilometers: Double = Double(totalDistanceInMeters / 1000)
        totalDistance = "Total Distance: \(distanceInKilometers) Km"
        
        
        let mins = totalDurationInSeconds / 60
        let hours = mins / 60
        let days = hours / 24
        let remainingHours = hours % 24
        let remainingMins = mins % 60
        let remainingSecs = totalDurationInSeconds % 60
        
        totalDuration = "Duration: \(days) d, \(remainingHours) h, \(remainingMins) mins, \(remainingSecs) secs"
    }
    
    
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
        if let lookupAddress = address {
            var geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            geocodeURLString = geocodeURLString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            
            let geocodeURL = NSURL(string: geocodeURLString)
            
            DispatchQueue.main.async {
                let geocodingResultsData = NSData(contentsOf: geocodeURL! as URL)
                do{
                    let dictionary: Dictionary<NSObject, AnyObject> = try JSONSerialization.jsonObject(with: geocodingResultsData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<NSObject, AnyObject>
                    
                    // Get the response status.
                    let status = dictionary["status" as NSObject] as! String
                    if status == "OK" {
                        let allResults = dictionary["results" as NSObject] as! Array<Dictionary<NSObject, AnyObject>>
                        self.lookupAddressResults = allResults[0]
                        
                        // Keep the most important values.
                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address" as NSObject] as! String
                        let geometry = self.lookupAddressResults["geometry" as NSObject] as! Dictionary<NSObject, AnyObject>
                        self.fetchedAddressLongitude = ((geometry["location" as NSObject] as! Dictionary<NSObject, AnyObject>)["lng" as NSObject] as! NSNumber).doubleValue
                        self.fetchedAddressLatitude = ((geometry["location" as NSObject] as! Dictionary<NSObject, AnyObject>)["lat" as NSObject] as! NSNumber).doubleValue
                        
                        completionHandler(status, true)
                    }
                    else {
                        completionHandler(status, false)
                    }
                } catch{
                    print("error")
                    completionHandler("", false)
                }
            }
        }
    }
}

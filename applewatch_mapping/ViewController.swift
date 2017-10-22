//
//  ViewController.swift
//  applewatch_mapping
//
//  Created by yifu on 9/6/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

//@interface MyLocationViewController : UIViewController <CLLocationManagerDelegate>

class ViewController: UIViewController {
    
    
    let _sc : SessionController = SessionController();
    let _mapcon : MapController = MapController();
    let searchController : UISearchController = UISearchController();
    
    override func viewDidLoad() {
        super.viewDidLoad();
      
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    @objc func switchView(){
        
    }
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //trying to make uiimage
    @objc func getLoc(sender: UIButton, event: UIEvent){
        _sc.send_image()
    }


}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}


// let camera = GMSCamera
//let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.switchView))
//singleTap.numberOfTapsRequired = 1 // you can change this value
//image.isUserInteractionEnabled = true;
//image.addGestureRecognizer(singleTap);

/*mapview.delegate = mapCon;
 let mkc : MKCoordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 30, longitude: 80), MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.2));
 mapview.setRegion(mkc, animated: true)
 // Do any additional setup after loading the view, typically from a nib.
 //sc.send_image();
 mapCon.map_prepare(mapview: mapview)
 do{
 try mapCon.startGettingLocations()
 }catch(LocationException.authorizationDenied){
 alerting(title : "Authorization Denied", message : "Map service needs your location info.");
 locationMan.requestAlwaysAuthorization();
 }catch(LocationException.authorizationRestricted){
 NSLog("error: authorization restricted")
 }catch(LocationException.authorizationUndetermined){
 NSLog("error: authorization udetermined")
 }catch(LocationException.locationServiceNotEnabled){
 NSLog("error: location not enable")
 }catch(LocationException.locDelNotSet){
 NSLog("error: no deleagte for locations")
 }catch(LocationException.mapViewNotSet){
 NSLog("error: no map view")
 }catch{
 NSLog("error: some error idk")
 }*/
/*}
 @IBAction func getLocation(sender: UIButton, event: UIEvent){
 do {
 let userLoc: CLLocation? = try self.mapCon.getUserCurrentLocation();
 if let coor:CLLocationCoordinate2D = userLoc?.coordinate{
 mapview.setCenter(coor, animated: true);
 }
 
 }catch(LocationException.authorizationDenied){
 print("Some means to error handling")
 }
 catch(LocationException.authorizationRestricted){}
 catch(LocationException.authorizationUndetermined){}
 catch{}
 
 }
 @objc func get_c(sender: UIButton, event: UIEvent){
 do {
 let userLoc: CLLocation? = try self.mapCon.getUserCurrentLocation();
 if(userLoc == nil){
 longLabel.text = String("nil")
 alerting(title : "nil", message : "why are you nil?");
 }
 if userLoc != nil{
 let coor : CLLocationCoordinate2D = userLoc!.coordinate;
 let lat :CLLocationDegrees = coor.latitude
 let long :CLLocationDegrees = coor.longitude
 longLabel.text = String(lat)
 latLabel.text  = String(long)
 //mapview.setCenter(coor, animated: true)
 }
 }catch(LocationException.authorizationDenied){
 longLabel.text = String("denied")
 }
 catch(LocationException.authorizationRestricted){
 longLabel.text = String("restri")
 }
 catch(LocationException.authorizationUndetermined){
 longLabel.text = String("undeter")
 }
 catch{
 longLabel.text = String("other")
 }
 }
 */


/*
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 */

           


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
import GooglePlaces

//@interface MyLocationViewController : UIViewController <CLLocationManagerDelegate>

class ViewController: UIViewController {
    let _sc : SessionController = SessionController();
    private var mapController : MapController?;
    @IBAction func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapController,
            segue.identifier == "goMapSegue" {
            self.mapController = vc
        }else{
            NSLog("Motherfucker didnt prepare");
        }
        
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


extension ViewController : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // runner.setCenter(place.coordinate)
        //let sboar : UIStoryboard = UIStoryboard(name:"Main", bundle:nil);
        if let map = self.mapController{
            map.setCenter(place.coordinate);
        }else{
            NSLog("Motherfucker didnt coord");
        }
        NSLog("coor is \(place.coordinate.latitude) + \(place.coordinate.longitude)");
        NSLog("runner is nil");
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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

           


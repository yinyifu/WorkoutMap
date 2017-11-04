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
    
    @IBAction func changeView(_ sender: Any){
        guard let mc = self.mapController else{
            print("Change View mc does not exist")
            return
        }
        mc.changeView();
    }
    
    @IBAction func well(_ sender: Any) {
        if let mc = self.mapController{
            if let ul = mc.getPerson(){
                mc.setCenter(ul);
                mc.setFollowing(true);
            }
        }
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
       // _sc.send_image()
    }
}


extension ViewController : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // runner.setCenter(place.coordinate)
        //let sboar : UIStoryboard = UIStoryboard(name:"Main", bundle:nil);
        if let map = self.mapController{
            map.routeTo(place.coordinate);
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

           


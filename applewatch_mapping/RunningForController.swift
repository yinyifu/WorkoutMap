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

class RunningForController: UIViewController {
    let _sc : SessionController = SessionController();
    private var mapController : MapController?;
    
    let range = 10
    

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
            segue.identifier == "runSegue" {
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
        
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200));
        let image :UIImage? = UIGraphicsGetImageFromCurrentImageContext();
        if let img = image{
            _sc.send_image(img)
        }else{
            NSLog("mother UIGraphic get image is hard to use Mother")
        }
    }
}


extension RunningForController : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // runner.setCenter(place.coordinate)
        //let sboar : UIStoryboard = UIStoryboard(name:"Main", bundle:nil);
        if let map = self.mapController{
            map.setCenter(place.coordinate)
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

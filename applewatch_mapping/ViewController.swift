//
//  ViewController.swift
//  applewatch_mapping
//
//  Created by Coding on 9/6/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//@interface MyLocationViewController : UIViewController <CLLocationManagerDelegate>

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var button: UIToolbar!
    
    @IBOutlet weak var longtitude: UILabel!
    @IBOutlet weak var langtitude: UILabel!
    @IBOutlet weak var rotation: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    @IBAction func doSomething(sender: UIButton, event: UIEvent){
        
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

}




           


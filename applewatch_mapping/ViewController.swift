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
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var rotation: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    var mapCon:MapController = MapController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(self.getLoc(sender:event:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    @IBAction func doSomething(sender: UIButton, event: UIEvent){
        do {
            let userLoc: CLLocation? = try self.mapCon.getUserCurrentLocation();
            if userLoc != nil{
                let coor : CLLocationCoordinate2D = userLoc!.coordinate;
                let lat :CLLocationDegrees = coor.latitude
                let long :CLLocationDegrees = coor.longitude
                longLabel.text = String(lat)
                latLabel.text  = String(long)
                
            }
        }catch(LocationException.authorizationDenied){
            print("Some means to error handling")
        }
        catch(LocationException.authorizationRestricted){}
        catch(LocationException.authorizationUndetermined){}
        catch{}
        
    }
    func getLoc(sender: UIButton, event: UIEvent){
        do {
            let userLoc: CLLocation? = try self.mapCon.getUserCurrentLocation();
            if userLoc != nil{
                let coor : CLLocationCoordinate2D = userLoc!.coordinate;
                let lat :CLLocationDegrees = coor.latitude
                let long :CLLocationDegrees = coor.longitude
                longLabel.text = String(lat)
                latLabel.text  = String(long)
                
            }
        }catch(LocationException.authorizationDenied){}
        catch(LocationException.authorizationRestricted){}
        catch(LocationException.authorizationUndetermined){}
        catch{}
        
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

}




           


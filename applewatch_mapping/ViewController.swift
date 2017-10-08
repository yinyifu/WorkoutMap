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
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var rotation: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    var mapCon:MapController = MapController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(self.getLoc(sender:event:)), for: .touchUpInside)
        mapview.delegate = mapCon;
        let mkc : MKCoordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 30, longitude: 80), MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.2));
        mapview.setRegion(mkc, animated: true)
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
                mapview.setCenter(coor, animated: true);
            
            }
        }catch(LocationException.authorizationDenied){
            print("Some means to error handling")
        }
        catch(LocationException.authorizationRestricted){}
        catch(LocationException.authorizationUndetermined){}
        catch{}
        
    }
    @objc func getLocation(sender: UIButton, event: UIEvent){
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
                //mapview.setCenter(coor, animated: true);
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
    
    func alerting(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    //trying to make uiimage
    @objc func getLoc(sender: UIButton, event: UIEvent){
        var sc : SessionController = SessionController();
        
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

}




           


import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {
 let cm = CLLocationManager();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        NSLog(String(mapView.mapType.hashValue));
        mapView.isMyLocationEnabled = true;
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        self.view = mapView;
        /*
       
        self.cm.requestAlwaysAuthorization();
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            let lc = LocationManagerController(mapview: mapView);
            self.cm.delegate = lc
            self.cm.desiredAccuracy = kCLLocationAccuracyBest;
            self.cm.startUpdatingLocation()
        }else{
            NSLog("Not authorized.");
        }
        */
    }
}

extension MapController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

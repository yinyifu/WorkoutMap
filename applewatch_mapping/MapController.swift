import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    var cmm : LocationManagerController?;
    var sc : SessionController?;
    var arrayOfDestination : [CLLocationCoordinate2D] = [];
    var arrayOfPath : [GMSMutablePath] = [];
    var arrayOfPolyLines : [GMSPolyline] = [];
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cmm = LocationManagerController(mapController: self);
        self.sc = SessionController();
        mapView.isMyLocationEnabled = true;
        mapView.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0);
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
        
        //self._mapView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        //self.view.addSubview(self._mapView)
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: -32.868, longitude: 151.208))
        
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        
    }
    func setCenter(_ coord:CLLocationCoordinate2D){
        mapView.camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 16.0);
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
    }
    func routeTo(_ coord:CLLocationCoordinate2D){
        let marker : GMSMarker = GMSMarker();
        marker.position=CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
        self.arrayOfDestination.append(coord);
        marker.icon = UIImage(named:"download") ;
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
        marker.map = self.mapView;
        let path : GMSMutablePath = GMSMutablePath();
        self.arrayOfPath.append(path);
        path.add(marker.position);
        NSLog("home mother");
        path.add(CLLocationCoordinate2DMake(self.mapView.camera.target.latitude, self.mapView.camera.target.longitude))
        let rectangle :GMSPolyline = GMSPolyline(path:path);
        rectangle.strokeWidth = 5.2;
        rectangle.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
        rectangle.map = self.mapView;
        self.arrayOfPolyLines.append( rectangle)
    }
    func routing_Update(){
        let size = self.arrayOfPath.endIndex;
        for index in stride(from: 0, to: size, by: 1){
            self.arrayOfPath[index].replaceCoordinate(at: 1, with: self.mapView.camera.target);
            self.arrayOfPolyLines[index].path = self.arrayOfPath[index];
        }
    }
    func send_an_image(){
        if let session = self.sc{
            
            let size : CGSize = self.mapView.bounds.size;
            let cropRet : CGRect = CGRect.init(x: self.mapView.bounds.maxX/2-20, y: self.mapView.bounds.maxY/2-20, width: 80, height: 40);
            
            /* Get the entire on screen map as Image */
            UIGraphicsBeginImageContext(size);
            if let contex = UIGraphicsGetCurrentContext(){
                self.mapView.layer.render(in: contex);
            }else{
                print("mother  I cant do this");
            }
            
            let mapImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            /* Crop the desired region */
            if let image = mapImage{
                let imageRef : CGImage? = image.cgImage!.cropping(to: cropRet);
                if let imageR = imageRef{
                    let imagesend = UIImage(cgImage: imageR);
                    session.send_image(imagesend);
                }
            }else{
                print("Mother this lib is way too hard mother")
            }
            /* Save the cropped image */
            //UIImageWriteToSavedPhotosAlbum(cropImage, nil, nil, nil);
            
            UIGraphicsEndImageContext();
        }
    }
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height);
    }
}


extension MapController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

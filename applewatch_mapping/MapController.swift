import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {
    
    //@IBOutlet var mapView: GMSMapView!
    var cmm : LocationManagerController?;
    var sc : SessionController?;
    var arrayOfPathes : [GMSMutablePath] = [];
    var arrayOfPolyLines : [GMSPolyline] = [];
    var userLocation : CLLocationCoordinate2D?;
    var mapview : GMSMapView?;
    let directionApi : String = "AIzaSyAaUoTiXpxA5jF6ik8yPgowKbnUtVtcxYQ";
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if(gesture ){
            if let loc = cmm{
                loc.following = false;
            }else{
                NSLog("Location manager is not currently set");
            }
        }else{
            NSLog("View is not moved by an user gesture");
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        if let loc = cmm{
            loc.following = false;
        }else{
            NSLog("Location manager is not currently set");
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cmm = LocationManagerController(mapController: self);
        self.sc = SessionController();
        let camera = GMSCameraPosition.camera(withLatitude: 1.285,longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        self.mapview = mapView
        
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
        
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: -32.868, longitude: 151.208))
        
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        self.view = mapView
    }
    func setFollowing(_ follow : Bool){
        if let loc = self.cmm{
            loc.following = follow
        }
    }
    func setCenter(_ coord:CLLocationCoordinate2D){
        if let mapView = self.mapview{
        mapView.camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 16.0);
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        }
    }
    func setCenterUser(_ coord:CLLocationCoordinate2D){
        if let mapView = self.mapview{
            self.userLocation = coord;
            mapView.camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 16.0);
            NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        }
    }
    func routeTo(_ coord:CLLocationCoordinate2D){
        if let mapVw = self.mapview{
            turn_two_points_into_a_profit(mapVw.camera.target, coord)
            let marker : GMSMarker = GMSMarker();
            marker.position=CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
            marker.map = mapVw;
            let path : GMSMutablePath = GMSMutablePath();
            self.arrayOfPathes.append(path);
            path.add(CLLocationCoordinate2DMake(mapVw.camera.target.latitude, mapVw.camera.target.longitude))
            path.add(marker.position);
            NSLog("home mother");
            let rectangle :GMSPolyline = GMSPolyline(path:path);
            rectangle.strokeWidth = 5.2;
            rectangle.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
            rectangle.map = mapVw;
            self.arrayOfPolyLines.append( rectangle)
        }
    }
    func getCenter() -> CLLocationCoordinate2D{
        
            return self.mapview!.camera.target;
    }
    func getPerson() -> CLLocationCoordinate2D?{
        return self.userLocation;
    }
    func addARoutes(_ coord:[CLLocationCoordinate2D]){
        if let mapVw = self.mapview{
        let path : GMSMutablePath = GMSMutablePath();
        self.arrayOfPathes.append(path);
        for coors in coord{
            let marker : GMSMarker = GMSMarker();
            marker.position=CLLocationCoordinate2DMake(coors.latitude, coors.longitude);
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
            marker.map = mapVw;
            path.add(CLLocationCoordinate2DMake(mapVw.camera.target.latitude, mapVw.camera.target.longitude))
            path.add(coors);
        }
        let rectangle :GMSPolyline = GMSPolyline(path:path);
        rectangle.strokeWidth = 5.2;
        rectangle.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
        rectangle.map = mapVw;
        self.arrayOfPolyLines.append( rectangle)
        }
    }
    
    
    func routing_Update(){
        if let mapView = self.mapview{
        let size = self.arrayOfPathes.endIndex;
        for index in stride(from: 0, to: size, by: 1){
            let locA : CLLocation = CLLocation.init(latitude: self.arrayOfPathes[index].coordinate(at: 0).latitude, longitude: self.arrayOfPathes[index].coordinate(at: 0).longitude)
            let locB : CLLocation = CLLocation.init(latitude: self.arrayOfPathes[index].coordinate(at: 1).latitude, longitude: self.arrayOfPathes[index].coordinate(at: 1).longitude)
            if locA.distance(from: locB) < 0.1{
                self.arrayOfPathes[index].removeCoordinate(at: 1)
                if(self.arrayOfPathes[index].count() <= 1){
                    self.arrayOfPathes.remove(at: index)
                    continue;
                }
            }
            self.arrayOfPathes[index].replaceCoordinate(at: 0, with: mapView.camera.target);
            self.arrayOfPolyLines[index].path = self.arrayOfPathes[index];
            
        }
        }
    }
    
    
    func changeView() {
        if let mapVw = self.mapview{
            let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .normal
            }
            
            let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .terrain
            }
            
            let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .hybrid
            }
            
            let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
                
            }
            
            actionSheet.addAction(normalMapTypeAction)
            actionSheet.addAction(terrainMapTypeAction)
            actionSheet.addAction(hybridMapTypeAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func resize(_ image: CGImage, _ x: Float , _ y: Float) -> CGImage? {
        var ratio: Float = 0.0
        let imageWidth = Float(image.width)
        let imageHeight = Float(image.height)
        let maxWidth: Float = x
        let maxHeight: Float = y
        
        // Get ratio (landscape or portrait)
        if (imageWidth > imageHeight) {
            ratio = maxWidth / imageWidth
        } else {
            ratio = maxHeight / imageHeight
        }
        
        // Calculate new size based on the ratio
        if ratio > 1 {
            ratio = 1
        }
        
        let width = imageWidth * ratio
        let height = imageHeight * ratio
        
        guard let colorSpace = image.colorSpace else { return nil }
        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: image.bitsPerComponent, bytesPerRow: image.bytesPerRow, space: colorSpace, bitmapInfo: image.alphaInfo.rawValue) else { return nil }
        
        // draw image to context (resizing it)
        context.interpolationQuality = .high
        context.draw(image, in: CGRect(x: 0, y: 0, width: Int(width), height: Int(height)))
        // extract resulting image from context
        return context.makeImage()
    }
    func turn_two_points_into_a_profit(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) {
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
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            let path : GMSMutablePath = GMSMutablePath();
            
        })
        task.resume()
    }
    /*
    @IBAction func createRoute(sender: AnyObject) {
        
        let addressAlert = UIAlertController(title: "Create Route", message: "Connect locations with a route:", preferredStyle: UIAlertControllerStyle.alert)
        
        addressAlert.addTextField { (textField) -> Void in
            //give a origin for route
            textField.text = "Toronto"
            textField.isUserInteractionEnabled = false
        }
        
        addressAlert.addTextField { (textField) -> Void in
            textField.placeholder = "Destination?"
        }
        
        
        let createRouteAction = UIAlertAction(title: "Create Route", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            let origin = (addressAlert.textFields![0] ).text as! String
            let destination = (addressAlert.textFields![1] ).text as! String
            
            self.mapTasks.getDirections(origin, destination: destination, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    self.configureMapAndMarkersForRoute()
                    self.drawRoute()
                    self.displayRouteInfo()
                }
                else {
                    println(status)
                }
            })
        }
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        addressAlert.addAction(createRouteAction)
        addressAlert.addAction(closeAction)
        
        present(addressAlert, animated: true, completion: nil)
    }
 */
    func send_an_image(){
        if let mapVw = self.mapview{
        if let session = self.sc{
            
            let size : CGSize = mapVw.bounds.size;
            let cropRet : CGRect = CGRect.init(x: mapVw.bounds.maxX/2-80, y: mapVw.bounds.maxY/2-80, width: 160, height: 160);
            
            /* Get the entire on screen map as Image */
            UIGraphicsBeginImageContext(size);
            if let contex = UIGraphicsGetCurrentContext(){
                mapVw.layer.render(in: contex);
            }else{
                print("Can not find a context current context.");
            }
            
            let mapImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            /* Crop the desired region */
            if let image = mapImage{
                let imageRef : CGImage? = image.cgImage!.cropping(to: cropRet);
                
                if let imageR = imageRef{
                    if let raaa:CGImage = imageR{
                        let imagesend = UIImage.init(cgImage: raaa);
                            session.send_image(imagesend);
                    }
                }
            }else{
                print("Map image does not exist")
            }
            /* Save the cropped image */
            //UIImageWriteToSavedPhotosAlbum(cropImage, nil, nil, nil);
            
            UIGraphicsEndImageContext();
        }
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

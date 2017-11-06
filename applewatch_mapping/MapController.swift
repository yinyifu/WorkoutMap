import UIKit
import GoogleMaps
import CoreLocation
/*credit : https://www.appcoda.com/google-maps-api-tutorial/  Helped a lot during developemnt of this code*/


class MapController: UIViewController, GMSMapViewDelegate {
    
    //@IBOutlet var mapView: GMSMapView!
    var cmm : LocationManagerController?;
    var sc : SessionController?;
    var pathes : GMSMutablePath?;
    var polyLines : GMSPolyline?;
    var userLocation : CLLocationCoordinate2D?;
    var mapview : GMSMapView?;
    var mark : GMSMarker?;
    var place_name : String?;
    var mapTasks :mapTasksLib = mapTasksLib();
    var markersArray: Array<GMSMarker> = []
    var waypointsArray: Array<String> = []
    let directionApi : String = "AIzaSyAaUoTiXpxA5jF6ik8yPgowKbnUtVtcxYQ";
    
    var timerTime : NSDate!;
    var timerOn = false;
    
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
        
        self.view = mapView
        
        self.send_an_image();
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
        self.send_an_image()
    }
    
    func setCenterUser(_ coord:CLLocationCoordinate2D){
        if let mapView = self.mapview{
            self.userLocation = coord;
            mapView.camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 16.0);
            NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        }
    }
    
    func routeToDots(_ coord:CLLocationCoordinate2D, _ string: String?){
        self.place_name = string;
        if let str = string{
            let coord2 : CLLocationCoordinate2D = self.getPerson()!;
            let loc0 = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
            let loc1 = CLLocation.init(latitude: coord2.latitude, longitude: coord2.longitude)
            
            let distance = loc0.distance(from: loc1)
            
            let modified_distance = distance * Double(Float(arc4random())/Float(UINT32_MAX)*2+0.7)
            let minutes = Int(modified_distance/60);
            
            let alert = UIAlertController(title: "Mission", message: "You have \(minutes) minutes to finish the race.", preferredStyle : UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Start", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            timerOn = true;
            timerTime = NSDate.init()
            timerTime = timerTime.addingTimeInterval(modified_distance)
            
            
            
            self.mapTasks.getDirections234( coord2,  coord, str, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    DispatchQueue.main.async {
                        
                        if let ple =  self.polyLines{
                            self.clearRoute()
                        }
                        
                        self.configureMapAndMarkersForRoute()
                        
                        self.drawRoute()
                        self.displayRouteInfo()
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: status, preferredStyle : UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    func routeTo2(_ coord:CLLocationCoordinate2D, _ string: String?){
        self.place_name = string;
        if let str = string{
            let coord2 : CLLocationCoordinate2D = self.getPerson()!;
            
            let locA : CLLocation = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
            let locB : CLLocation = CLLocation.init(latitude: coord2.latitude, longitude: coord2.longitude)
            if locA.distance(from: locB) > 100000{
                DispatchQueue.main.async {
                    
                
                let alert = UIAlertController(title: "Don't stress yourself too much", message: "The place you searched is too far from you.", preferredStyle : UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Oh.", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
                return;
                }
            
            self.mapTasks.getDirections234( coord2,  coord, str, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    DispatchQueue.main.async {
                        
                        if let ple =  self.polyLines{
                            self.clearRoute()
                        }
                        self.configureMapAndMarkersForRoute()
                        self.drawRoute()
                        self.displayRouteInfo()
                        }
                    }
                else {
                    let alert = UIAlertController(title: "Error", message: status, preferredStyle : UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    func routeTo(_ coord:CLLocationCoordinate2D, _ string: String?){
        self.place_name = string;
        if let mapVw = self.mapview{
        if let path = self.pathes, let poly = self.polyLines, let marker = self.mark{
            //turn_two_points_into_a_profit(mapVw.camera.target, coord)
            marker.position=CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
            marker.map = mapVw;
            path.removeAllCoordinates()
            path.add(CLLocationCoordinate2DMake(self.userLocation!.latitude, self.userLocation!.longitude))
            path.add(marker.position);
            poly.strokeWidth = 2.4;
            poly.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
            poly.map = mapVw
            poly.path = path
            polyLines = poly
        }else{
            let path : GMSMutablePath = GMSMutablePath();
            pathes = path;
            addMarker (coord)
            path.add(CLLocationCoordinate2DMake(self.userLocation!.latitude, self.userLocation!.longitude))
            path.add(self.mark!.position);
            let rectangle :GMSPolyline = GMSPolyline(path:path);
            rectangle.strokeWidth = 3.4;
            rectangle.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
            rectangle.map = mapVw
            polyLines = rectangle
            }
        }
    }
    func addMarker (_ coordinate:CLLocationCoordinate2D){
        if let mapVw = self.mapview{
            let marker : GMSMarker = GMSMarker();
            self.mark = marker;
            marker.title = self.place_name
            marker.appearAnimation = .pop
            marker.icon = GMSMarker.markerImage(with: UIColor.blue)
            marker.opacity = 0.75
            marker.position=CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
            marker.isFlat = true
            marker.snippet = "Start running toward there."
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
            marker.map = mapVw;
        }
    }
    func getCenter() -> CLLocationCoordinate2D{
            return self.mapview!.camera.target;
    }
    func getPerson() -> CLLocationCoordinate2D?{
        return self.userLocation;
    }
    @IBOutlet var lblText: UILabel!
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    
    func configureMapAndMarkersForRoute() {
        if let mapVW = self.mapview{
            mapVW.animate(toLocation: self.getPerson()!)
            originMarker = GMSMarker(position: self.getPerson()!)
            originMarker.map = self.mapview
            originMarker.icon = GMSMarker.markerImage(with: UIColor.green)
            originMarker.title = self.mapTasks.originAddress
            
            destinationMarker = GMSMarker(position: self.mapTasks.destinationCoordinate)
            destinationMarker.map = self.mapview
            destinationMarker.icon = GMSMarker.markerImage(with: UIColor.red)
            destinationMarker.title = self.mapTasks.destinationAddress
            markersArray.append(originMarker)
            markersArray.append(destinationMarker)
            if waypointsArray.count > 0 {
                for waypoint in waypointsArray {
                    let lat: Double = (waypoint.split(separator: ",")[0] as NSString).doubleValue
                    let lng: Double = (waypoint.split(separator: ",")[1] as NSString).doubleValue
                    
                    let marker = GMSMarker(position: CLLocationCoordinate2DMake(lat, lng))
                    marker.map = self.mapview
                    marker.icon = GMSMarker.markerImage(with: UIColor.purple)
                    
                    markersArray.append(marker)
                }
            }
        }
    }
    
    func configureMapAndMarkersForRouteNoRecenter() {
        originMarker = GMSMarker(position: self.mapTasks.originCoordinate)
        originMarker.map = self.mapview
        originMarker.icon = GMSMarker.markerImage(with: UIColor.green)
        originMarker.title = self.mapTasks.originAddress
        
        destinationMarker = GMSMarker(position: self.mapTasks.destinationCoordinate)
        destinationMarker.map = self.mapview
        destinationMarker.icon = GMSMarker.markerImage(with: UIColor.red)
        destinationMarker.title = self.mapTasks.destinationAddress
        if waypointsArray.count > 0 {
            for waypoint in waypointsArray {
                let lat: Double = (waypoint.split(separator: ",")[0] as NSString).doubleValue
                let lng: Double = (waypoint.split(separator: ",")[1] as NSString).doubleValue
                
                let marker = GMSMarker(position: CLLocationCoordinate2DMake(lat, lng))
                marker.map = self.mapview
                marker.icon = GMSMarker.markerImage(with: UIColor.purple)
                
                markersArray.append(marker)
            }
        }
    }
    
    func displayRouteInfo(){
        lblText.text = mapTasks.totalDistance + "\n" + mapTasks.totalDuration
    }
    func recreateRoute() {
        if let polyline = self.polyLines {
            clearRoute()
            
            mapTasks.getDirections234(self.getPerson()!, mapTasks.destinationCoordinate, mapTasks.destinationAddress, waypoints: waypointsArray, travelMode: nil, completionHandler: { (status, success) -> Void in
                
                if success {
                    DispatchQueue.main.async {
                        if let _ = self.polyLines, let _ = self.originMarker{
                            self.clearRoute()
                        }
                        
                        self.configureMapAndMarkersForRoute()
                        self.drawRoute()
                        self.displayRouteInfo()
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: status, preferredStyle : UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    func clearRoute() {
        originMarker.map = nil
        destinationMarker.map = nil
        if let ple =  self.polyLines{
            self.polyLines!.map = nil
        }
        originMarker = nil
        destinationMarker = nil
        self.polyLines = nil
        
        if markersArray.count > 0 {
            for marker in markersArray {
                marker.map = nil
            }
            
            markersArray.removeAll(keepingCapacity: false)
        }
    }
    
    func drawRoute() {
        let route = mapTasks.overviewPolyline["points" ] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        let poly = GMSPolyline(path: path)
        self.polyLines = poly
        poly.strokeWidth = 2.4;
        poly.strokeColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8);
        
        poly.map = self.mapview
        DispatchQueue.main.async {
            sleep(1)
            self.send_an_image()
        }
    }
    
    func routing_Update(){
        if let mapView = self.mapview{
            if let pathes = self.pathes, let polyLines = self.polyLines{
                let locA : CLLocation = CLLocation.init(latitude: pathes.coordinate(at: 0).latitude, longitude: pathes.coordinate(at: 0).longitude)
                let locB : CLLocation = CLLocation.init(latitude: pathes.coordinate(at: 1).latitude, longitude: pathes.coordinate(at: 1).longitude)
                if locA.distance(from: locB) < 0.1{
                    pathes.removeCoordinate(at: 1)
                    if(pathes.count() <= 1){
                        self.pathes = nil
                        self.polyLines!.path = nil
                    }
                }
                if let someone = self.getPerson() {
                    pathes.replaceCoordinate(at: 0, with: someone);
                    polyLines.path = pathes;
                }
            }
        }
    }
    func routingUpdate(){
        if(timerOn){
            let new_time = NSDate.init()
            if(new_time.compare(self.timerTime as Date).rawValue > 0){
                timerOn = false;
                let alert = UIAlertController(title: "Time is up!", message: "Run faster next time.", preferredStyle : UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Start", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if let person = self.getPerson(){
            self.mapTasks.originCoordinate = person
            let locA : CLLocation = CLLocation.init(latitude: person.latitude, longitude: person.longitude)
            let locB : CLLocation = CLLocation.init(latitude: self.mapTasks.destinationCoordinate.latitude, longitude: self.mapTasks.destinationCoordinate.longitude)
            
            if locA.distance(from: locB) < 15{
                self.reachHandler();
            }
            self.configureMapAndMarkersForRouteNoRecenter();
            recreateRoute();
            
        }
    }
    func reachHandler(){
        if(timerOn){
            let alert = UIAlertController(title: "You did it!", message: "Good job", preferredStyle : UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            timerOn = false
        }else{
            let alert = UIAlertController(title: "Heyy", message: "Your destination is reached", preferredStyle : UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func changeView() {
        if let mapVw = self.mapview{
            let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .normal
                DispatchQueue.main.async {
                    sleep(1)
                    self.send_an_image()
                }
                
            }
            
            let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .terrain
                DispatchQueue.main.async {
                    sleep(1)
                    self.send_an_image()
                }
            }
            
            let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                mapVw.mapType = .hybrid
                DispatchQueue.main.async {
                    sleep(1)
                    self.send_an_image()
                }
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
    /*
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
 */
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
                    let imagesend = UIImage.init(cgImage: imageR);
                        session.send_image(imagesend);
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

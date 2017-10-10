//
//  locationDelegate.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 9/27/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation
import CoreLocation
protocol locationDelegate : CLLocationManagerDelegate {
    func onUserLocationChange();
    func onUserChosenLocationChange();
    func onUserDirectionLocationChange();
    
}

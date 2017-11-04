//
//  File.swift
//  applewatch_mapping
//
//  Created by IOS Design Coding on 11/2/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

import Foundation
import UIKit

class HowManyController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    
    
    
}

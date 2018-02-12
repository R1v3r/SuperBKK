//
//  RouteListCell.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class RouteListCell: CollectionViewCell {
    
    @IBOutlet weak var RouteName: UILabel!
    @IBOutlet weak var RouteDescription: UILabel!
    
    override func reset() {
        super.reset()
        
        self.RouteName.text = nil
        self.RouteDescription.text = nil
    }
}

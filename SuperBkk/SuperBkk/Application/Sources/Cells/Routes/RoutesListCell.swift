//
//  RoutesListCell.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 19..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class RoutesListCell: CollectionViewCell {
    
    @IBOutlet weak var RouteLabel: UILabel!
    @IBOutlet weak var RouteNameLabel: UILabel!
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    override func reset() {
        self.RouteLabel.text = nil
        self.RouteNameLabel.text = nil
        self.DirectionLabel.text = nil
        self.TimeLabel.text = nil
    }
}

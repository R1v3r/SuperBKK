//
//  StopsListCell.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 19..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class StopsListCell: CollectionViewCell {
    
    @IBOutlet weak var StopNameLabel: UILabel!
    
    override func reset() {
        self.StopNameLabel.text = nil
    }
}

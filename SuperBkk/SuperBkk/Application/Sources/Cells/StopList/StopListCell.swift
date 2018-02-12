//
//  StopListCell.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class StopListCell: CollectionViewCell {
    
    @IBOutlet weak var StopName: UILabel!
    
    override func reset() {
        super.reset()
        
        self.StopName.text = nil
    }
    
}

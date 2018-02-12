//
//  CollectionViewCell.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell
{
    static var reuseIdentifier: String { return String(describing: self) }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.reset()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.reset()
    }
    
    func reset() {}
}

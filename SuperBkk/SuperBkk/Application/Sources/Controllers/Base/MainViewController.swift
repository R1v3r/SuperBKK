//
//  MainViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

final class MainViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ((UIApplication.shared.delegate as? AppDelegate)?.window) != nil else {
            return
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(NavigationViewController(rootViewController:StopsListViewController()), animated: animated, completion: nil)
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

//
//  CollectionViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: ViewController {
    
    weak var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
        
        self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive   = true
        self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive     = true
        self.view.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive           = true
        
        self.collectionView.backgroundColor = UIColor(red: 228, green: 241, blue: 254, alpha: 0)
        self.collectionView.tintColor = UIColor(red: 68, green: 108, blue: 179, alpha: 0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 68, green: 108, blue: 179, alpha: 0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func noNetworkNotification(notificaiton: NSNotification) {
        OperationQueue.main.addOperation({
            let alertController = UIAlertController(title: "Nincs internetkapcsolat!", message: "A megfelelő müködéshez internetelérés szükséges", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Rendben", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        })
    }
}

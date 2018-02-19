//
//  StopsListViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 14..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit
import CoreLocation

class StopsListViewController: CollectionViewController {
    
    var dataSource: [Stop] = []
    let baseLocation = CLLocation(latitude: 47.497509, longitude: 19.054193)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: StopsListCell.reuseIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: StopsListCell.reuseIdentifier)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate   = self
        
        self.reload()
    }
    
    override func initialize() {
        super.initialize()
    }
    
    func reload() {
       self.collectionView.reloadData()
    }
}

extension StopsListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StopsListCell.reuseIdentifier, for: indexPath) as? StopsListCell
        cell?.StopNameLabel.text = String(self.dataSource[indexPath.row].stop_name)
        return cell!
    }
}

extension StopsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = RoutesListViewController()
        viewController.stop_id = self.dataSource[indexPath.row].stop_id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension StopsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt insetForSectionAtIndex: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
}

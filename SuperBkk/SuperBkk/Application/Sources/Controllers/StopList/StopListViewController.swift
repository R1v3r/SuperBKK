//
//  StopListViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit
import CoreLocation

class StopListViewController: CollectionViewController {
    
    var dataSource: [Stop] = []
    let baseLocation = CLLocation(latitude: 47.497509, longitude: 19.054193)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: StopListCell.reuseIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: StopListCell.reuseIdentifier)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate   = self
        
        self.reload()
    }
    
    override func initialize() {
        super.initialize()
    }
    
    func reload() {
        Alamofire.request(SuperchargeApi.get)
            .responseJSON { response in
                print(response.description)
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                
                if let responseJSON = response.result.value {
                    Stop.parseList(from: (responseJSON as AnyObject))
                        .then{stops -> Void in
                            self.dataSource = stops.filter({ (stop: Stop) -> Bool in
                                let stopLocation = CLLocation(latitude: stop.stop_lat, longitude: stop.stop_lon)
                                return (stopLocation.distance(from: self.baseLocation) <= 1000 && stop.stop_code != "")
                            })
                    }
                }
        }
    }
}

extension StopListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StopListCell.reuseIdentifier, for: indexPath) as? StopListCell
        cell?.StopName.text = String(self.dataSource[indexPath.row].stop_name)
        return cell!
    }
}

extension StopListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = RouteListViewController()
        viewController.stop_id = self.dataSource[indexPath.row].stop_id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension StopListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt insetForSectionAtIndex: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
}

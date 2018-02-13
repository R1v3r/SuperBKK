//
//  RouteListViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit

class RouteListViewController: CollectionViewController {
    
    var stop_id: String = ""
    var dataSource: [Route] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: RouteListCell.reuseIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: RouteListCell.reuseIdentifier)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate   = self
        
        self.reload()
    }
    
    override func initialize() {
        super.initialize()
    }
    
    func reload() {
        Alamofire.request(BkkApi.stop(self.stop_id))
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                
                if let responseJSON = response.result.value as? [String: Any] {
                    if let data = responseJSON["data"] as? [String: Any] {
                        if let references = data["references"] as? [String: Any] {
                            if let routes = references["routes"] as? [String: Any] {
                                let myGroup = DispatchGroup()
                                
                                for i in 0 ..< routes.count {
                                    myGroup.enter()
                                    
                                    Route.parse(from: routes[Array(routes.keys)[i]] as AnyObject)
                                        .then{ parsed -> Void in
                                            self.dataSource.append(parsed)
                                            myGroup.leave()
                                    }
                                }
                                
                                myGroup.notify(queue: .main) {
                                    self.collectionView.reloadData()
                                }
                            }
                        }
                    }
                }
        }
    }
    
}

extension RouteListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RouteListCell.reuseIdentifier, for: indexPath) as? RouteListCell
        cell?.RouteName.text = String(self.dataSource[indexPath.row].shortName)
        cell?.RouteDescription.text = String(self.dataSource[indexPath.row].description)
        cell?.RouteName.backgroundColor = UIColor(hexString: self.dataSource[indexPath.row].color)
        cell?.RouteName.textColor = UIColor(hexString: self.dataSource[indexPath.row].textColor)
        return cell!
    }
}

extension RouteListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension RouteListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt insetForSectionAtIndex: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
}

//
//  StopsMapViewController.swift
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
import MapKit

class StopsMapViewController: ViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var dataSource: [Stop] = []
    var annotationPlaces: [AnnotationPlace] = []
    var currentPlace : AnnotationPlace = AnnotationPlace(title: "Itt állsz", locationName: "", discipline: "", coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(47.497509), CLLocationDegrees(19.054193)))
    let baseLocation = CLLocation(latitude: 47.497509, longitude: 19.054193)
    private let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        centerMapOnLocation(location: baseLocation)
        
        self.reload()
    }
    
    override func initialize() {
        super.initialize()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(ShowStopsList))
    }
    
    func reload() {
        Alamofire.request(SuperchargeApi.get)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching stops: \(String(describing: response.result.error))")
                    return
                }
                
                if let responseJSON = response.result.value {
                    Stop.parseList(from: (responseJSON as AnyObject))
                        .then{stops -> Void in
                            self.dataSource = stops.filter({ (stop: Stop) -> Bool in
                                let stopLocation = CLLocation(latitude: stop.stop_lat, longitude: stop.stop_lon)
                                return (stopLocation.distance(from: self.baseLocation) <= 1000 && stop.stop_code != "")
                            })
                            for stop in self.dataSource {
                                let location = CLLocationCoordinate2D(latitude: stop.stop_lat, longitude: stop.stop_lon)
                                let annotationPin = AnnotationPlace(title: stop.stop_name, locationName: stop.stop_code, discipline: "StopPin", coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(location.latitude), CLLocationDegrees(location.longitude)))
                                self.annotationPlaces.append(annotationPin)
                                self.mapView.addAnnotation(annotationPin)
                            }
                            self.annotationPlaces.append(self.currentPlace)
                            self.mapView.showAnnotations(self.annotationPlaces, animated: true)
                        }
                }
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegin = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        self.mapView.setRegion(coordinateRegin, animated: true)
    }
    
    @objc func ShowStopsList() {
        
    }
}

extension StopsMapViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? AnnotationPlace
        {
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                let calloutButton = UIButton(type: .detailDisclosure)
                pinView!.rightCalloutAccessoryView = calloutButton
                pinView!.sizeToFit()
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation as? MKAnnotation {
                let stopCode = self.dataSource.filter({ (stop: Stop) -> Bool in
                    return stop.stop_code == annotation.description
                })
                let viewController = RoutesListViewController()
                //viewController.stop_id = self.dataSource[indexPath.row].stop_id
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView])
    {
        var i = -1;
        for view in views
        {
            i = i + 1;
            if view.annotation is MKUserLocation
            {
                continue;
            }
            let point:MKMapPoint  =  MKMapPointForCoordinate(view.annotation!.coordinate);
            if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point))
            {
                continue;
            }
            let endFrame:CGRect = view.frame
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - self.view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
            let delay = 0.03 * Double(i)
            UIView.animate(withDuration: 0.5, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations:
                {() in
                    view.frame = endFrame
            }, completion:{(Bool) in
                UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations:
                    {() in
                        view.transform = CGAffineTransform(scaleX: 1.0, y: 0.6)
                }, completion:
                    {(Bool) in
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations:
                            {() in
                                view.transform = CGAffineTransform.identity
                        }, completion: nil)
                })
                
            })
        }
    }
}

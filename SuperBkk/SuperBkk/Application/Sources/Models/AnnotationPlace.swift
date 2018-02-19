//
//  AnnotationPlace.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 14..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class AnnotationPlace: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String
    var discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
    }
    
    var subtitle: String?
    {
        return locationName
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDictonary = [String(CNPostalAddressStreetKey): self.subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictonary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    func pinColor() -> UIColor  {
        switch discipline {
        default:
            return UIColor.red
        }
    }
}

//
//  PlaceModel.swift
//  myPlaces
//
//  Created by MacBook on 18.02.2021.
//

import UIKit


struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let myPlaces = ["Были тут", "Hookah Place", "Chelentano", "MZE", "Певческая башня", "Tandur", "Грушенька"]

    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in myPlaces {
            places.append(Place(name: place, location: "Saint-P", type: "Ресторан", image: nil,
                                restaurantImage: place))
        }
        
        return places
    }
    
}

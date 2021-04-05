//
//  MapViewController.swift
//  myPlaces
//
//  Created by Даниил Хантуров on 05.04.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var place = Place()
    let annotationIdentifier = "annotationIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlaceMark()
    }
    
    @IBAction func cancelMap() {
        dismiss(animated: true)
    }
    
    private func setupPlaceMark() {
        guard let location = place.location else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else {return}
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else {return}
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {return nil}
        
        var annotatiomView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotatiomView == nil {
            annotatiomView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotatiomView?.canShowCallout = true
        }
        
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotatiomView?.rightCalloutAccessoryView = imageView
        }
        
        return annotatiomView
    }
}

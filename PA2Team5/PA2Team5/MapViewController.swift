//
//  MapViewController.swift
//  PA2Team5
//
//  Created by ubicomp5 on 10/25/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var contactData = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateMap() {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let location = CLLocationCoordinate2DMake(contactData.hq_latitude, contactData.hq_longitude)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        let location2 = CLLocation(latitude: self.contactData.hq_latitude, longitude: self.contactData.hq_longitude)
        
        CLGeocoder().reverseGeocodeLocation(location2) {
            (placemark, error) in if error != nil {
                print("ERROR")
            } else {
                if let place = placemark?[0] {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = "\(self.contactData.company)"
                    annotation.subtitle = "\(place.locality!), \(place.administrativeArea!), \(place.isoCountryCode!)"
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

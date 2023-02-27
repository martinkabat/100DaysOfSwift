//
//  ViewController.swift
//  Project22
//
//  Created by Martin Kabát on 11.02.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var noOfTimesDetected = 0 {
        didSet {
//            if noOfTimesDetected == 1 {
//                let ac = UIAlertController(title: "Beacon detected!", message: "A beacon has been detected for the first time!", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Okie dokie", style: .default))
//                present(ac, animated: true)
//            }
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        distanceReading = UILabel()
        distanceReading.translatesAutoresizingMaskIntoConstraints = false
        distanceReading.textAlignment = .center
        distanceReading.text = "UNKNOWN"
        distanceReading.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        view.addSubview(distanceReading)
        
        beaconLabel = UILabel()
        beaconLabel.translatesAutoresizingMaskIntoConstraints = false
        beaconLabel.textAlignment = .center
        beaconLabel.text = "BEACON NO."
        beaconLabel.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        view.addSubview(beaconLabel)

        
        NSLayoutConstraint.activate([
            // centered horizontally and vertically, slightly up the center
            distanceReading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceReading.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            // centered horizontally and vertically, slightly down the center
            beaconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beaconLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: +25)
        ])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
//        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        // mbeacon Mac
        // in terminal
        // defaults write mbeacon measuredPower -integer -55
        // mbeacon -uuid "F2FD5214-AD07-11ED-AFA1-0242AC120002" -major 123 -minor 456
        let uuid = UUID(uuidString: "F2FD5214-AD07-11ED-AFA1-0242AC120002")!
        let beaconIdentityConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: beaconIdentityConstraint, identifier: "MyBeacon")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconIdentityConstraint)
        
//        let uuid2 = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
//        let beaconIdentityConstraint2 = CLBeaconIdentityConstraint(uuid: uuid2, major: 123, minor: 456)
//        let beaconRegion2 = CLBeaconRegion(beaconIdentityConstraint: beaconIdentityConstraint2, identifier: "MyBeacon2")
//        locationManager?.startMonitoring(for: beaconRegion2)
//        locationManager?.startRangingBeacons(satisfying: beaconIdentityConstraint2)
//
//        let uuid3 = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
//        let beaconIdentityConstraint3 = CLBeaconIdentityConstraint(uuid: uuid3, major: 123, minor: 456)
//        let beaconRegion3 = CLBeaconRegion(beaconIdentityConstraint: beaconIdentityConstraint3, identifier: "MyBeacon3")
//        locationManager?.startMonitoring(for: beaconRegion3)
//        locationManager?.startRangingBeacons(satisfying: beaconIdentityConstraint3)
//
        
        
    }
    
    func update(distance: CLProximity, beaconName: String?) {
        UIView.animate(withDuration: 1) {
            switch distance {
                case .far:
                self.noOfTimesDetected += 1
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.beaconLabel.text = beaconName
                
                case .near:
                self.noOfTimesDetected += 1
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.beaconLabel.text = beaconName
                
                case .immediate:
                self.noOfTimesDetected += 1
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.beaconLabel.text = beaconName
                
                default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
//                self.beaconLabel.text = beaconName
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            print(beacon)
            print(region)
            let name = region.uuid.description
            let bcn = name.prefix(7)
            update(distance: beacon.proximity, beaconName: String(bcn))
        } else {
            update(distance: .unknown, beaconName: nil)
        }
    }
    
}

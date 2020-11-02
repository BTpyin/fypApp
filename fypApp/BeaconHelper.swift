//
//  BeaconHelper.swift
//  fypApp
//
//  Created by Bowie Tso on 31/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import CoreLocation

class BeaconHelper{
    var locationManager : CLLocationManager?
    
    
    init(){
        locationManager = CLLocationManager()
//        locationManager?.requestAlwaysAuthorization()
    }
    
    func getUUID() -> UUID{
        return UUID(uuidString: Global.beaconUUID)!
    }
    
    func monitorBeacons() {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            let proximityUUID = UUID(uuidString: Global.beaconUUID)
            let beaconId = "deeplove"
            let region = CLBeaconRegion(proximityUUID: proximityUUID!, identifier: beaconId)
            locationManager?.startMonitoring(for: region)
            locationManager?.startRangingBeacons(in: region)
        }
        
    }
    
    func stopMonitorBeacon(){
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            let proximityUUID = UUID(uuidString: Global.beaconUUID)
            let beaconId = "deeplove"
            let region = CLBeaconRegion(proximityUUID: proximityUUID!, identifier: beaconId)
            locationManager?.stopMonitoring(for: region)
            locationManager?.stopRangingBeacons(in: region)
            locationManager?.stopUpdatingLocation()
//            locationManager?.stopRangingBeacons(in: region)
        }
    }
}

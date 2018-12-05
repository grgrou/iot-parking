//
//  IPParkingBE.swift
//  iParking
//
//  Created by Felix Chacaltana on 12/3/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

class IPParkingBE: NSObject {
    
    var parking_id      = ""
    var parking_state   = 0
    
    class func parse(_ json: CSMJSON)-> IPParkingBE {
        
        let objBE = IPParkingBE()
        
        objBE.parking_id    = json.dictionary["id"]?.stringValue ?? "-"
        objBE.parking_state = json.dictionary["state"]?.intValue ?? 0
        
        return objBE
        
    }
}

class IPRegisterParkingBE: NSObject {
    
    var register_dni        = ""
    var register_license    = ""
    var register_name       = ""
    var register_lastName   = ""
    var register_parking    = ""
}

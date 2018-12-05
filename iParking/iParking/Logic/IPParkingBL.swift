//
//  IPParkingBL.swift
//  iParking
//
//  Created by Felix Chacaltana on 12/3/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

class IPParkingBL: NSObject {

    class func getComboParking(_ success: @escaping ArrayParkings, error: @escaping ErrorMessage) {
        IPParkingWS.getComboParking(success, error: error)
    }
    
    class func registerParking(_ objRegisterParking: IPRegisterParkingBE, success: @escaping Success, error: @escaping ErrorMessage) {
        IPParkingWS.registerParking(objRegisterParking, success: success, error: error)
    }
    
    class func getDni(_ dni: String, success: @escaping DniInformation, error: @escaping ErrorMessage) {
        IPParkingWS.getDni(dni, success: success, error: error)
    }
}

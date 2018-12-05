//
//  IPParkingWS.swift
//  iParking
//
//  Created by Felix Chacaltana on 12/3/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

class IPParkingWS: NSObject {

    class func getComboParking(_ success: @escaping ArrayParkings, error: @escaping ErrorMessage) {
        
        CSMWebServiceManager.shared.request.postRequest(urlString: URLIParkingWS.getComboParking, parameters: nil) { (response) in
            
            if let status = response.JSON?.dictionary["status"]?.boolValue, status == true, let data = response.JSON?.dictionary["data"] {
                
                var arrayParking = [IPParkingBE]()
                
                for data in data.array {
                    arrayParking.append(IPParkingBE.parse(data))
                }
                
                success(arrayParking)
                
            } else {
                let errorMessage = response.JSON?.dictionary["message"]?.stringValue ?? Message.genericErrorMessage
                error(errorMessage)
            }
            
        }
    }
    
    class func registerParking(_ objRegisterParking: IPRegisterParkingBE, success: @escaping Success, error: @escaping ErrorMessage) {
        
        let dic : [String: Any] = ["dni"        : objRegisterParking.register_dni,
                                   "license"    : objRegisterParking.register_license,
                                   "name"       : objRegisterParking.register_name,
                                   "last_name"  : objRegisterParking.register_lastName,
                                   "parking"    : objRegisterParking.register_parking]
        
        CSMWebServiceManager.shared.request.postRequest(urlString: URLIParkingWS.registerParking, parameters: dic) { (response) in
            
            if let status = response.JSON?.dictionary["status"]?.boolValue, status == true {
                success()
            } else {
                let errorMessage = response.JSON?.dictionary["message"]?.stringValue ?? Message.genericErrorMessage
                error(errorMessage)
            }
            
        }
    }
    
    class func getDni(_ dni: String, success: @escaping DniInformation, error: @escaping ErrorMessage) {
        
        let dic : [String: Any] = ["dni": dni]
        
        CSMWebServiceManager.shared.request.postRequest(urlString: URLIParkingWS.getDni, parameters: dic) { (response) in
            
            if let status = response.JSON?.dictionary["status"]?.boolValue, status == true, let data = response.JSON?.dictionary["data"] {
                
                let name = "\(data.dictionary["pri_nom"]?.stringValue?.capitalized ?? "") \(data.dictionary["seg_nom"]?.stringValue?.capitalized ?? "")"
                let lastName = "\(data.dictionary["ap_pat"]?.stringValue?.capitalized ?? "") \(data.dictionary["ap_mat"]?.stringValue?.capitalized ?? "")"
                
                success(name, lastName)
                
            } else {
                let errorMessage = response.JSON?.dictionary["message"]?.stringValue ?? Message.genericErrorMessage
                error(errorMessage)
            }
            
        }
    }
    
}

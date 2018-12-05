//
//  IPConstants.swift
//  iParking
//
//  Created by Felix Chacaltana on 10/13/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

struct Message {
    
    static let alertTitle           = "iParking"
    static let alertAcceptButton    = "Aceptar"
    static let genericErrorMessage  = "Ocurrió un error inesperado. Por favor, inténtalo más tarde."
    static let emptyArrayParkings   = "No se han encontrado parkings ocupados."
    static let successfulRegister   = "Registro completado. En 2 horas deberá sacar su auto."
}

struct Colors {
    
    static let transparentBlack = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.35)
}

struct Segue {
    
    static let IPParkingSelectorViewController = "IPParkingSelectorViewController"
}

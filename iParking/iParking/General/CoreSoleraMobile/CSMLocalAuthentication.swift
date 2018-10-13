//
//  CSMLocalAuthentication.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 7/5/18.
//

import UIKit
import LocalAuthentication

public enum CSMLAError : String {
    case appCancel              = "El proceso de autenticación fué cancelado por la aplicación."
    case authenticationFailed   = "La autenticación ingresada es incorrecta."
    case invalidContext         = "El contexto de la autenticación es invá lido."
    case passcodeNotSet         = "No tienes una clave de seguridad configurada en tu dispositivo."
    case systemCancel           = "El proceso de autenticación fué cancelado por el sistema."
    case biometryLockout        = "Se superó el número de intentos de autenticación."
    case biometryNotAvailable   = "La autenticación biométrica no esta disponible en este dispositivo."
    case biometryNotEnrolled    = "Aun no registra una clave biométrica en este dispositivo."
    case userCancel             = "El proceso fué cancelado."
    case userFallback           = "El proceso de autenticación está intentando usar el respaldo de iCloud."
    case none                   = "El proceso de autenticación está temporalmente fuera de servicio."
    
}

public extension UIViewController{

    public func verifyLocalAuthenticationWith(reason: String, withSuccess success: @escaping ()->Void, withFailure failure: @escaping (_ errorMessage: String, _ laError: CSMLAError)->Void){
        
        let contexto = LAContext()
     
        if contexto.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            
            contexto.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (isSuccess, error) in
                
                DispatchQueue.main.async{
                    
                    if isSuccess {
                        success()
                    }else{
                        let csmError = self.errorMessageFor(errorCode: (error as NSError?)?.code ?? -1)
                        failure(csmError.rawValue, csmError)
                    }
                    
                }
                
            }

        }else{
            failure(CSMLAError.passcodeNotSet.rawValue, .passcodeNotSet)
        }
    }
    
    private func errorMessageFor(errorCode: Int) -> CSMLAError {
    
        switch errorCode {
        case LAError.appCancel.rawValue:
            return CSMLAError.appCancel
        case LAError.authenticationFailed.rawValue:
            return CSMLAError.authenticationFailed
        case LAError.invalidContext.rawValue:
            return CSMLAError.invalidContext
        case LAError.passcodeNotSet.rawValue:
            return CSMLAError.passcodeNotSet
        case LAError.systemCancel.rawValue:
            return CSMLAError.systemCancel
        case LAError.biometryLockout.rawValue:
            return CSMLAError.biometryLockout
        case LAError.biometryNotAvailable.rawValue:
            return CSMLAError.biometryNotAvailable
        case LAError.biometryNotEnrolled.rawValue:
            return CSMLAError.biometryNotEnrolled
        case LAError.userCancel.rawValue:
            return CSMLAError.userCancel
        case LAError.userFallback.rawValue:
            return CSMLAError.userFallback
        default:
            return CSMLAError.none
        }
    }
}

//
//  IPRegisterCarViewController.swift
//  iParking
//
//  Created by Felix Chacaltana on 10/13/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

class IPRegisterCarViewController: UIViewController, IPParkingSelectorViewControllerDelegate {
    
    @IBOutlet weak var imgVerticalConstraint    : NSLayoutConstraint!
    @IBOutlet weak var viewVerticalConstraint   : NSLayoutConstraint!
    @IBOutlet weak var viewGradient             : CSMLinearGradientView!
    @IBOutlet weak var viewBox                  : CSMShadowView!
    @IBOutlet weak var txtDni                   : CSMTextField!
    @IBOutlet weak var txtPlaca                 : CSMTextField!
    @IBOutlet weak var txtParking               : CSMTextField!
    @IBOutlet weak var btnRegister              : CSMButton!
    @IBOutlet weak var indicatorParkings        : UIActivityIndicatorView!
    @IBOutlet weak var indicatorRegister        : UIActivityIndicatorView!
    
    var arrayParkings = [IPParkingBE]()
    
    // MARK: - Click Events
    @IBAction func clickBtnSelectParking(_ sender: CSMTextField) {
        
        self.view.endEditing(true)
        self.getComboParking()
    }
    
    @IBAction func clickBtnRegister() {
        
        self.indicatorRegister.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        IPParkingBL.getDni(txtDni.text ?? "", success: { (name, lastName) in
            
            let objBE = IPRegisterParkingBE()
            
            objBE.register_dni      = self.txtDni.text ?? ""
            objBE.register_license  = self.txtPlaca.text ?? ""
            objBE.register_parking  = self.txtParking.text ?? ""
            objBE.register_name     = name
            objBE.register_lastName = lastName
            
            IPParkingBL.registerParking(objBE, success: {
                
                self.indicatorRegister.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
                self.showAltert(withTitle: Message.alertTitle, withMessage: Message.successfulRegister, withAcceptButton: Message.alertAcceptButton, withCompletion: nil)
                
            }, error: { (errorMessage) in
                self.indicatorRegister.stopAnimating()
                self.view.isUserInteractionEnabled = true
                self.showAltert(withTitle: Message.alertTitle, withMessage: errorMessage, withAcceptButton: Message.alertAcceptButton, withCompletion: nil)
            })
            
        }) { (errorMessage) in
            self.indicatorRegister.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.showAltert(withTitle: Message.alertTitle, withMessage: errorMessage, withAcceptButton: Message.alertAcceptButton, withCompletion: nil)
        }
    }
    
    
    // MARK: - IPParkingSelectorViewControllerDelegate
    func IPParkingSelectorViewController(_ controller: IPParkingSelectorViewController, didSelectParking parking: IPParkingBE) {
        self.txtParking.text = parking.parking_id
    }
    
    
    // MARK: - Web Service
    func getComboParking() {
        
        self.indicatorParkings.startAnimating()
        self.btnRegister.isUserInteractionEnabled = false
        self.txtParking.isUserInteractionEnabled  = false
        
        IPParkingBL.getComboParking({ (arrayParkings) in
            
            self.indicatorParkings.stopAnimating()
            self.btnRegister.isUserInteractionEnabled = true
            self.txtParking.isUserInteractionEnabled  = true
            self.txtParking.text = nil
            
            self.arrayParkings = arrayParkings
            self.performSegue(withIdentifier: Segue.IPParkingSelectorViewController, sender: nil)
            
        }) { (errorMessage) in
            
            self.indicatorParkings.stopAnimating()
            self.btnRegister.isUserInteractionEnabled = true
            self.txtParking.isUserInteractionEnabled  = true
            self.txtParking.text = nil
            
            self.showAltert(withTitle: Message.alertTitle, withMessage: errorMessage, withAcceptButton: Message.alertAcceptButton, withCompletion: nil)
        }
    }

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgVerticalConstraint.constant = -self.viewGradient.bounds.height
        self.viewGradient.alpha = 0
        self.viewVerticalConstraint.constant = UIScreen.main.bounds.height / 2;
        self.viewBox.alpha  = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.2, delay: 0.3, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.1, options: [], animations: {
            
            self.viewVerticalConstraint.constant = 0
            self.viewBox.alpha  = 1
            
            self.imgVerticalConstraint.constant = 0
            self.viewGradient.alpha = 1
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Keyboard
    @IBAction func keyboardTapHide(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.IPParkingSelectorViewController {
            
            let controller = segue.destination as! IPParkingSelectorViewController
            
            controller.delegate = self
            controller.arrayParkings = self.arrayParkings
        }
    }
    
}

//
//  IPParkingSelectorViewController.swift
//  iParking
//
//  Created by Felix Chacaltana on 11/28/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

protocol IPParkingSelectorViewControllerDelegate {
    
    func IPParkingSelectorViewController(_ controller: IPParkingSelectorViewController, didSelectParking parking: IPParkingBE)
}
class IPParkingSelectorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView               : UIPickerView!
    @IBOutlet weak var constraintBottonPicker   : NSLayoutConstraint!
    
    var delegate        : IPParkingSelectorViewControllerDelegate?
    var arrayParkings   = [IPParkingBE]()
    
    // MARK: - Click Events
    @IBAction func tapHidePicker(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.35, animations: {
            self.view.backgroundColor = .clear
            self.constraintBottonPicker.constant = -UIScreen.main.bounds.height
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayParkings.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrayParkings[row].parking_id
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.IPParkingSelectorViewController(self, didSelectParking: self.arrayParkings[row])
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.constraintBottonPicker.constant = -UIScreen.main.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.35) {
            self.view.backgroundColor = Colors.transparentBlack
            self.constraintBottonPicker.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

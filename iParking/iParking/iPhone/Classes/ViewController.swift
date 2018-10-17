//
//  ViewController.swift
//  iParking
//
//  Created by Felix Chacaltana on 10/13/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewVerticalConstraint: NSLayoutConstraint!
    
    // MARK: - Keyboard
    @IBAction func keyboardTapHide(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
//        let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewVerticalConstraint.constant = UIScreen.main.bounds.height / 2;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.2, delay: 0.3, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.1, options: [], animations: {
            
            self.viewVerticalConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

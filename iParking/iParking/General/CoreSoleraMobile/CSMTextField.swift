//
//  CSMTextField.swift
//  CoreSoleraMobile
//
//  Created by Mateo Espinoza on 21/03/18.
//  Copyright © 2018 Mateo Espinoza. All rights reserved.
//

import UIKit

enum CSMAllowTypeText: Int {
    case number
    case text
    case special
    case number_text
    case all
}

@IBDesignable public class CSMTextField: UITextField {
    
    @IBInspectable public var borderColor : UIColor{
        
        get{
            if let cgBorderColor = self.layer.borderColor{
                return UIColor(cgColor: cgBorderColor)
            }else{
                return .clear
            }
        }
        set(newValue){
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth
        }
        set(newValue){
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = (newValue < 0) ? 0 : newValue
            self.layer.masksToBounds = (self.layer.cornerRadius != 0)
        }
    }
    
    @IBInspectable public var topMargin : CGFloat{
        get{
            return self.edgeMargin.top
        }
        set(newValue){
            self.edgeMargin.top = newValue
        }
    }
    
    @IBInspectable public var leftMargin : CGFloat{
        get{
            return self.edgeMargin.left
        }
        set(newValue){
            self.edgeMargin.left = newValue
        }
    }
    
    @IBInspectable public var rightMargin : CGFloat{
        get{
            return self.edgeMargin.right
        }
        set(newValue){
            self.edgeMargin.right = newValue
        }
    }
    
    @IBInspectable public var bottomMargin : CGFloat{
        get{
            return self.edgeMargin.bottom
        }
        set(newValue){
            self.edgeMargin.bottom = newValue
        }
    }
    
    @IBInspectable public var leftImage : UIImage?{
        get{
            if let contentView = self.leftView,
                let imageView = contentView.viewWithTag(1) as? UIImageView,
                let image = imageView.image{
                return image
            }else{
                return nil
            }
        }
        set(newValue){
            if let image = newValue{
                
                let contentView = UIView(frame:CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: self.frame.height,
                                                      height: self.frame.height))
                
                let imageView = UIImageView(frame: CGRect(x: self.frame.height*0.25,
                                                          y: self.frame.height*0.25,
                                                          width: self.frame.height*0.5,
                                                          height: self.frame.height*0.5))
                
                imageView.contentMode = .scaleToFill
                imageView.image = image
                imageView.tag = 1
                contentView.addSubview(imageView)
                contentView.isUserInteractionEnabled = false
                self.leftView = contentView
                self.leftViewMode = .always
                self.leftMargin = self.frame.height
            }else{
                self.leftView = nil
                self.leftViewMode = .never
                self.leftMargin = 0.0
            }
        }
    }
    
    @IBInspectable public var rightImage : UIImage?{
        get{
            if let contentView = self.rightView,
                let imageView = contentView.viewWithTag(1) as? UIImageView,
                let image = imageView.image{
                return image
            }else
            {
                return nil
            }
        }
        set(newValue){
            if let image = newValue{
                
                let contentView = UIView(frame:CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: self.frame.height,
                                                      height: self.frame.height))
                
                let imageView = UIImageView(frame: CGRect(x: self.frame.height*0.25,
                                                          y: self.frame.height*0.25,
                                                          width: self.frame.height*0.5,
                                                          height: self.frame.height*0.5))
                
                imageView.contentMode = .scaleToFill
                imageView.image = image
                imageView.tag = 1
                imageView.isUserInteractionEnabled = false
                contentView.addSubview(imageView)
                contentView.isUserInteractionEnabled = false
                self.rightView = contentView
                self.rightViewMode = .always
                self.rightMargin = self.frame.height
            }else{
                self.rightView = nil
                self.rightViewMode = .never
                self.rightMargin = 0.0
            }
        }
    }
    
    @IBInspectable public var onlyNumbers  : Bool = false
    @IBInspectable public var maxLength  : Int = 0
    
    @IBInspectable public var shadowColor : UIColor{
        get{
            if let color = self.layer.shadowColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.black
            }
        }
        set(newValue){
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var shadowOffset : CGSize{
        get{
            return self.layer.shadowOffset
        }
        set(newValue){
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var shadowRadius : CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set(newValue){
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable public var shadowOpacity : Float{
        get{
            return self.layer.shadowOpacity
        }
        set(newValue){
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public var placeholderColor : UIColor{
        get{
            return self.internalPlaceholderColor
        }
        set{
            self.internalPlaceholderColor = newValue
            let attribute = NSMutableAttributedString(attributedString: NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: self.internalPlaceholderColor]))
            self.attributedPlaceholder = attribute
        }
    }
    
    
    private var internalPlaceholderColor = UIColor.lightGray
    private var edgeMargin : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.borderColor = UIColor.white
        self.borderWidth = 0.0
        self.leftImage = nil
        self.rightImage = nil
        self.deleteBackward()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        
        self.addTarget(self, action: #selector(self.changeTextWhenUseIsTyping(sender:)), for: .editingChanged)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    @objc private func changeTextWhenUseIsTyping(sender: UITextField){
        
        let textAllowed = self.onlyNumbers ? "0-9" : ""
        var result = self.text?.replacingOccurrences( of:"[^\(textAllowed)]", with: "", options: .regularExpression)
        if result?.count ?? 0 > self.maxLength{
            result = result?.replacing(range: self.maxLength...(result?.count ?? self.maxLength) - 1, with: "")
        }
        
        sender.text = result
    }
    
}

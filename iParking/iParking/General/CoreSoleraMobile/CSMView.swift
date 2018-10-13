//
//  CSMView.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 22/03/18.
//

import UIKit

@IBDesignable
public class CSMRadialGradientView: UIView {

    @IBInspectable public var insideColor : UIColor = UIColor.clear
    @IBInspectable public var outSideColor : UIColor = UIColor.clear
    
    @IBInspectable public var gradiantCenter : CGPoint{
        set(newValue){
            self.internalGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalGradiantCenter
        }
    }
    
    @IBInspectable public var startRadius : CGFloat{
        set(newValue){
            if newValue > 1 {
                self.internalStartRadius = 1
            }else if newValue < 0 {
                self.internalStartRadius = 0
            }else{
                self.internalStartRadius = newValue
            }
        }
        get{
            return self.internalStartRadius
        }
    }
    
    @IBInspectable public var endRadius : CGFloat{
        set(newValue){
            if newValue > 1 {
                self.internalEndRadius = 1
            }else if newValue < 0 {
                self.internalEndRadius = 0
            }else{
                self.internalEndRadius = newValue
            }
        }
        get{
            return self.internalEndRadius
        }
    }
    
    var internalGradiantCenter = CGPoint.zero
    var internalStartRadius : CGFloat = 0
    var internalEndRadius: CGFloat = 0.5
    
    override public func draw(_ rect: CGRect) {
        
        self.createGradientWithStartRadius(self.startRadius, withEndRadius: self.endRadius)        
    }
    
    private func createGradientWithStartRadius(_ startRadius: CGFloat, withEndRadius endRadius: CGFloat){
        
        let colors = [self.insideColor.cgColor, self.outSideColor.cgColor] as CFArray
        
        let endGradientRadius = min(frame.width, frame.height) * endRadius
        let startGradientRadius = min(frame.width, frame.height) * startRadius
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let center = CGPoint(x: width / 2 + (width / 2 * self.gradiantCenter.x), y: height / 2 + (height / 2 * self.gradiantCenter.y))
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()?.drawRadialGradient(gradient!, startCenter: center, startRadius: startGradientRadius, endCenter: center, endRadius: endGradientRadius, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
    }
    
    public func animateGradientWithStartRadius(_ startRadius: CGFloat, withEndRadius endRadius: CGFloat){

        UIView.animate(withDuration: 2) {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            
            self.createGradientWithStartRadius(startRadius, withEndRadius: endRadius)
            
            CATransaction.commit()
        }
    }
}

@IBDesignable
public class CSMLinearGradientView: UIView {
    
    @IBInspectable public var startColor : UIColor = UIColor.clear
    @IBInspectable public var endColor : UIColor = UIColor.clear
    
    @IBInspectable public var startGradiantCenter : CGPoint{
        set(newValue){
            self.internalStartGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalStartGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalStartGradiantCenter
        }
    }
    
    @IBInspectable public var endGradiantCenter : CGPoint{
        set(newValue){
            self.internalEndGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalEndGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalEndGradiantCenter
        }
    }
    
    var internalStartGradiantCenter = CGPoint.zero
    var internalEndGradiantCenter = CGPoint.zero
    
    override public func draw(_ rect: CGRect) {
        
        let colors = [self.startColor.cgColor, self.endColor.cgColor] as CFArray
    
        let width = bounds.size.width
        let height = bounds.size.height
        
        let startCenter = CGPoint(x: width / 2 + (width / 2 * self.startGradiantCenter.x), y: height / 2 + (height / 2 * self.startGradiantCenter.y))
        let endCenter = CGPoint(x: width / 2 + (width / 2 * self.endGradiantCenter.x), y: height / 2 + (height / 2 * self.endGradiantCenter.y))
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()?.drawLinearGradient(gradient!, start: startCenter, end: endCenter, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
        
    }
    
}

@IBDesignable
public class CSMLinearThreeColorsGradientView: UIView {
    
    @IBInspectable public var startColor : UIColor = UIColor.clear
    @IBInspectable public var middleColor : UIColor = UIColor.clear
    @IBInspectable public var endColor : UIColor = UIColor.clear
    
    @IBInspectable public var startGradiantCenter : CGPoint{
        set(newValue){
            self.internalStartGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < 0 ? 0 : newValue.x
            self.internalStartGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < 0 ? 0 : newValue.y
        }
        get{
            return self.internalStartGradiantCenter
        }
    }
    
    @IBInspectable public var endGradiantCenter : CGPoint{
        set(newValue){
            self.internalEndGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < 0 ? 0 : newValue.x
            self.internalEndGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < 0 ? 0 : newValue.y
        }
        get{
            return self.internalEndGradiantCenter
        }
    }
    
    var internalStartGradiantCenter = CGPoint.zero
    var internalEndGradiantCenter = CGPoint.zero
    
    override public func draw(_ rect: CGRect) {
        
        let colors = [self.startColor.cgColor, self.middleColor.cgColor]
        
        let gradients = CAGradientLayer()
        gradients.colors = colors
        gradients.frame = self.bounds
        
        gradients.endPoint = self.startGradiantCenter
        gradients.startPoint = self.endGradiantCenter
        
        self.layer.addSublayer(gradients)
    }
    
}

@IBDesignable
public class CSMShadowView: UIView{
 
    @IBInspectable public var borderColor : UIColor{
        get{
            if let color = self.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.white
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
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
        }
    }
    public override func awakeFromNib() {
        
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = false
    }
}

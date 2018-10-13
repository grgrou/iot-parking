//
//  CSMLabel.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 10/2/18.
//

import UIKit

@IBDesignable public class CSMLabel: UILabel{
    
    @IBInspectable public var spaceLine : CGFloat{
        get{
            return self.internalSpaceLine
        }
        set(newValue){
            self.internalSpaceLine = newValue
            self.setSpaceLineInText()
        }
    }
    
    fileprivate var internalSpaceLine : CGFloat = 0.0
    
    fileprivate func setSpaceLineInText(){
        
        let labelText = self.text ?? ""
        let alignText = self.textAlignment
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.internalSpaceLine
        paragraphStyle.alignment = alignText
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

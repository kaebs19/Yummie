//
//  UIView+Extension.swift
//  Yummie
//
//  Created by mjeed on 18/09/2023.
//

import Foundation
import UIKit

extension UIView {
    
  @IBInspectable  var cornerRadius:CGFloat {
        get {return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}

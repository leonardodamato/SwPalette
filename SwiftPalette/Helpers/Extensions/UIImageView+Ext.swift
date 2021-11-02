//
//  UIImageView+Ext.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import Foundation
import UIKit

extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

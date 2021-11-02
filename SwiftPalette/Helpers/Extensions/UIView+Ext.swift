//
//  UIView+Ext.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-24.
//

import Foundation
import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        return (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
    
    var statusBarHeight: CGFloat {
        return (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    }
}

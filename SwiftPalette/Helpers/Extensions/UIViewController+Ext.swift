//
//  UIViewController+Ext.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import Foundation
import UIKit

@nonobjc extension UIViewController {
    func add(child: UIViewController) {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

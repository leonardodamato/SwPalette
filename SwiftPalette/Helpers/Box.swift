//
//  Box.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import Foundation

class Box<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

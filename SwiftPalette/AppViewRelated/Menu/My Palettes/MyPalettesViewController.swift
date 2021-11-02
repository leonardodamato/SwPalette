//
//  MyPalettesViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class MyPalettesViewController: UIViewController {

    let viewModel = MyPalettesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = viewModel.viewControllerTitle
        
        print("oi")
    }
    

    
    
    func configureView() {
        let myPalettesView = MyPalettesView(viewModel: viewModel, viewController: self)
        view = myPalettesView
    }
}

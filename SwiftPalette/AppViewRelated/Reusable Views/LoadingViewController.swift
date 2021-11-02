//
//  LoadingViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var spiner: UIImageView!
    
    var loadingView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = false
        parent?.view.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false 
        return view
        
    }
     
    override func viewDidLoad() {
        view = loadingView
        configureSpinner()
        //isModalInPresentation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        parent?.view.isUserInteractionEnabled = true

    }
    
    
    func configureSpinner() {
        spiner = UIImageView(image: UIImage(named: "spiner"))
        view.addSubview(spiner)
        spiner.translatesAutoresizingMaskIntoConstraints = false
        
        spiner.contentMode = . scaleAspectFit
        
        NSLayoutConstraint.activate([
            spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spiner.heightAnchor.constraint(equalToConstant: 60),
            spiner.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        spiner.rotate()
    }
}

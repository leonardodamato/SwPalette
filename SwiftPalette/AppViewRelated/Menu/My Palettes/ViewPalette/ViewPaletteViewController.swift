//
//  ViewPaletteViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit
import CloudKit
import CoreData

class ViewPaletteViewController: UIViewController {

    var reloadTableViewAfterDismissViewPaletteViewController: Action?
    var paletteViewController: PaletteViewController!
    var id: Int
    var isTopColorDark: Bool = false
    var isPaletteSaved: Bool = true
    
    var button: UIButton!
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reloadTableViewAfterDismissViewPaletteViewController?()
    }
    
    
    
    func configure() {
        
        view.backgroundColor = .systemBackground

        paletteViewController = PaletteViewController()
        add(child: paletteViewController)
        
        let loadingViewController = LoadingViewController()
        add(child: loadingViewController)
        
        paletteViewController.getPalette(id: id) {
            loadingViewController.remove()
            self.configureSaveButton()
        }
    }
    
    
    func configureSaveButton() {
        button =  UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
                
        let tintColor: UIColor = isTopColorDark ? .white : .black
        let image = UIImage(systemName: "heart.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(saveOrUnsavePalette), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    @objc func saveOrUnsavePalette() {
        guard let palette = paletteViewController.viewModel.palette.value else { return }

        ///Unsave
        ///
        if paletteViewController.viewModel.isPaletteSaved(palette: palette) {
            paletteViewController.viewModel.unsavePalette(palette: palette, completion: {
                let tintColor: UIColor = self.isTopColorDark ? .white : .black
                let image = UIImage(systemName: "heart")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
                self.button.setImage(image, for: .normal)
            })
        }
        
        ///Save
        ///
        else {
            paletteViewController.viewModel.savePalette(palette: palette, completion: {
                let tintColor: UIColor = self.isTopColorDark ? .white : .black
                let image = UIImage(systemName: "heart.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
                self.button.setImage(image, for: .normal)
            })
        }
    }
}

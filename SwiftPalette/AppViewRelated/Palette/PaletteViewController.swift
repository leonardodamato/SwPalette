//
//  PaletteViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import UIKit



class PaletteViewController: UIViewController {

    let viewModel = PaletteViewModel()
    var paletteView: PaletteView?
    
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: - UI Configuration
    
    
    //MARK: - Actions
    func getRandomPalette(completion: @escaping ()->()) {
        viewModel.getRandomPalette { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.palette.bind { palette in
                self.paletteView = PaletteView(viewModel: self.viewModel)
                self.view = self.paletteView
                self.viewModel.isPaletteSaved = self.viewModel.isPaletteSaved(palette: palette!)
                completion()
            }
        }
    }
    
    func getPalette(id: Int, completion: @escaping ()->()) {
        viewModel.getPalette(id: id) { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.palette.bind { palette in
                self.paletteView = PaletteView(viewModel: self.viewModel)
                self.view = self.paletteView
                self.viewModel.isPaletteSaved = self.viewModel.isPaletteSaved(palette: palette!)
                completion()
            }
        }
    }

}

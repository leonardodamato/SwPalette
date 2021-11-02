//
//  HomeViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var paletteViewController: PaletteViewController!
    var controlsView: UIView!
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addPaletteViewController()
        leftSideBarButtons()
        rightSideButton()
    }
    
    func addPaletteViewController() {
        paletteViewController = PaletteViewController()
        add(child: paletteViewController)
        
        let loadingViewController = LoadingViewController()
        add(child: loadingViewController)
        paletteViewController.getRandomPalette {
            self.addNavBarTitleView()
            loadingViewController.remove()
        }
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            getNextPalette()
        }
    }
    
    
    //MARK: - NavigationBar
    
    func addNavBarTitleView() {
        let palette = paletteViewController.viewModel.palette.value!
        
        let navBarTitleViewModel = NavBarTitleViewModel(palette: palette)
        navigationItem.titleView = NavBarTitleView(viewModel: navBarTitleViewModel)
    }
    
    
    func leftSideBarButtons() {
        ///Save Button
        ///
        let saveImage = paletteViewController.viewModel.isPaletteSaved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let saveBarButtonItem = UIBarButtonItem(image: saveImage, style: .plain, target: self, action: #selector(saveOrUnsavePalette))
        saveButton = saveBarButtonItem

        ///Next Palette Button
        ///
        let nextPaletteImage = UIImage(systemName: "arrow.right.circle")
        let nextPaletteButton = UIBarButtonItem(image: nextPaletteImage, style: .plain, target: self, action: #selector(getNextPalette))
        
        navigationItem.leftBarButtonItems = [saveButton, nextPaletteButton]
    }
    
    
    func rightSideButton() {
        let menuImage = UIImage(systemName: "line.horizontal.3")
        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(goToMenu))
        
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    
    @objc func getNextPalette() {
        let loadingViewController = LoadingViewController()
        add(child: loadingViewController)
        paletteViewController.getRandomPalette {
            self.addNavBarTitleView()
            self.updateSaveButtonState()
            loadingViewController.remove()
        }
        
    }
    
    func updateSaveButtonState() {
        let saveImage = paletteViewController.viewModel.isPaletteSaved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        saveButton.image = saveImage
    }
    
    
    @objc func goToMenu() {
        let vc = MenuListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func saveOrUnsavePalette() {
        guard let palette = paletteViewController.viewModel.palette.value else { return }

        ///Unsave
        ///
        if paletteViewController.viewModel.isPaletteSaved(palette: palette) {
            paletteViewController.viewModel.unsavePalette(palette: palette, completion: {
                self.saveButton.image = UIImage(systemName: "heart")

            })
        }
        
        ///Save
        ///
        else {
            paletteViewController.viewModel.savePalette(palette: palette, completion: {
                self.saveButton.image = UIImage(systemName: "heart.fill")
            })
        }
    }
    
    
    @objc func savePalette() {
        if !paletteViewController.viewModel.isPaletteSaved {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "PaletteEntity", in: context)!
            guard let paletteView = paletteViewController.paletteView else { return }
            guard let palette = paletteView.viewModel.palette.value else { return }
            
            
            let newPalette = NSManagedObject(entity: entity, insertInto: context)
            
            newPalette.setValue(palette.id, forKey: "id")
            newPalette.setValue(palette.title, forKey: "title")
            newPalette.setValue(palette.userName, forKey: "userName")
            newPalette.setValue(palette.numViews, forKey: "numViews")
            newPalette.setValue(palette.numVotes, forKey: "numVotes")
            newPalette.setValue(palette.numComments, forKey: "numComments")
            newPalette.setValue(palette.numHearts, forKey: "numHearts")
            newPalette.setValue(palette.rank, forKey: "rank")
            newPalette.setValue(palette.dateCreated, forKey: "dateCreated")
            newPalette.setValue(palette.colors, forKey: "colors")
            newPalette.setValue(palette.paletteDescription, forKey: "desc")
            newPalette.setValue(palette.url, forKey: "url")
            newPalette.setValue(palette.imageURL, forKey: "imageUrl")
            newPalette.setValue(palette.badgeURL, forKey: "badgeUrl")
            newPalette.setValue(palette.apiURL, forKey: "apiUrl")
            
            do {
                try context.save()
                saveButton.image = UIImage(systemName: "heart.fill")
            } catch {
                print("failed to save")
            }
        }
    }
}

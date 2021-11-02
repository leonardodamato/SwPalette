//
//  PaletteViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import UIKit
import CoreData

protocol PaletteViewModelProtocol {
    func hexColorString(color: String) -> String
    func getRandomPalette(completion: @escaping ()->())
    func getPalette(id: Int, completion: @escaping ()->())

    
    var palette: Box<Palette?> { get set }
    
    var isPaletteSaved: Bool { get set }
}


class PaletteViewModel: PaletteViewModelProtocol {

    var palette: Box<Palette?> = Box(nil)
    var isPaletteSaved: Bool = false
    
    
    func savePalette(palette: Palette, completion: @escaping () -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "PaletteEntity", in: context)!
        
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
            completion()
        } catch {
            print("failed to save")
        }
    }

    func unsavePalette(palette: Palette, completion: @escaping () -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PaletteEntity")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               
                let paletteId = data.value(forKey: "id") as! Int
                if  paletteId == palette.id { context.delete(data) }
                
                try context.save()
                completion()
          }
        } catch {
            print("Failed")
        }
    }
}


//MARK: PaletteViewController
extension PaletteViewModel {
    
    var getTopColor: String {
        guard let palette = palette.value else { return "ffffff"}
        return palette.colors[0]
    }
}


//MARK: PaletteView
extension PaletteViewModel {
    ///This function should receive a string containing 6 characters (F24513) and it will return the same value but with and '#' added as the first character
    ///eg: #F24513
    func hexColorString(color: String) -> String {
        return "#\(color)"
    }
    
    
    
    func registerTableViewCells(for tableView: ContentSizedTableView) {
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.reuseId)
    }
    
    func getRandomPalette(completion: @escaping ()->()) {
        
        PaletteService.getRandomPalette { [weak self] result in
            switch result {
            case .success(let palettes):
                self?.palette = Box(palettes[0])
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    
    func getPalette(id: Int, completion: @escaping ()->()) {
        
        PaletteService.getPalette(id: id) { [weak self] result in
            switch result {
            case .success(let palettes):
                self?.palette = Box(palettes[0])
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    
    func isPaletteSaved(palette: Palette) -> Bool {
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var isPaletteSaved = false
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PaletteEntity")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let id = data.value(forKey: "id") as! Int
                
                if id == palette.id {
                    isPaletteSaved = true
                }
          }
            
        } catch {
            print("Failed")
        }

        return isPaletteSaved
    }
}

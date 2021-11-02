//
//  MyPalettesViewModel.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit
import CoreData

protocol MyPalettesViewModelProtocol {
    var palettes: Box<[Palette]?> { get set }
    
    func getPalettes()
}

class MyPalettesViewModel: MyPalettesViewModelProtocol {
    
    
    
    init() {
        getPalettes()
    }
    
    var palettes: Box<[Palette]?> = Box(nil)
    
    ///ViewController Title
    ///
    var viewControllerTitle: String {
        return "My Palettes"
    }
    
    ///Get palettes saved by the user on their device
    /// 
    func getPalettes() {
        var myPalettes: [Palette] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PaletteEntity")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let id                 = data.value(forKey: "id") as! Int
                let title              = (data.value(forKey: "title") ?? "") as! String
                let userName           = (data.value(forKey: "userName") ?? "") as! String
                let numViews           = data.value(forKey: "numViews") as! Int
                let numVotes           = data.value(forKey: "numVotes") as! Int
                let numComments        = data.value(forKey: "numComments") as! Int
                let numHearts          = data.value(forKey: "numHearts") as! Int
                let rank               = data.value(forKey: "rank") as! Int
                let dateCreated        = (data.value(forKey: "dateCreated") ?? "") as! String
                let colors             = (data.value(forKey: "colors") ?? []) as! [String]
                let paletteDescription = (data.value(forKey: "desc") ?? "") as! String
                let url                = (data.value(forKey: "url") ?? "") as! String
                let imageURL           = (data.value(forKey: "imageUrl") ?? "") as! String
                let badgeURL           = (data.value(forKey: "badgeUrl") ?? "") as! String
                let apiURL             = (data.value(forKey: "apiUrl") ?? "") as! String
                
                let palette = Palette(id: id, title: title, userName: userName, numViews: numViews, numVotes: numVotes, numComments: numComments, numHearts: numHearts, rank: rank, dateCreated: dateCreated, colors: colors, paletteDescription: paletteDescription, url: url, imageURL: imageURL, badgeURL: badgeURL, apiURL: apiURL)
                
                myPalettes.append(palette)
          }
            
            palettes = Box(myPalettes)
            
        } catch {
            print("Failed")
        }
        
    }
    
    
    //MARK: - TableView Related
    let myPalettesCellReuseId = "MyPalettesCell"
    
    var numberOfRowsInSection: Int {
        guard let palettes = palettes.value  else { return 0 }

        return palettes.count
    }
    
    
    func registerCells(tableView: UITableView) {
        tableView.register(MyPalettesCell.self, forCellReuseIdentifier: myPalettesCellReuseId)
    }
}

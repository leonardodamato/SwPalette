//
//  MyPalettesView.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

typealias Action = () -> ()

class MyPalettesView: UIView {
    
    var viewController: UIViewController
    var viewModel: MyPalettesViewModel
    
    var tableView: UITableView!
    
    var palettes: [Palette] = []
    
    func reloadTableViewAfterDismissViewPaletteViewController() -> Action {
        return {
            self.viewModel.getPalettes()
            self.tableView.reloadData()
            
        }
      }
    
    //MARK: - Initializers
    init(viewModel: MyPalettesViewModel, viewController: UIViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)
        
        self.viewModel = MyPalettesViewModel()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Configuration
    func configureTableView() {
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .secondarySystemBackground

        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.registerCells(tableView: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


//MARK: - TableView Delegate and DataSource
extension MyPalettesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.myPalettesCellReuseId, for: indexPath) as! MyPalettesCell
        
        guard let palettes = viewModel.palettes.value else { return UITableViewCell() }
        
        cell.viewModel = MyPalettesCellViewModel(palette: palettes[indexPath.row])
        
        cell.configure()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let palettes = viewModel.palettes.value else { return }

        let id = palettes[indexPath.row].id
        
        let topColor = palettes[indexPath.row].colors[0]
        let isTopColorDark = HexToUIColor.convert(hex: topColor).isDarkColor
        
        let viewPaletteViewController = ViewPaletteViewController(id: id)
        viewPaletteViewController.reloadTableViewAfterDismissViewPaletteViewController = reloadTableViewAfterDismissViewPaletteViewController()
        viewPaletteViewController.isTopColorDark = isTopColorDark
        viewController.present(viewPaletteViewController, animated: true, completion: nil)
    }
}

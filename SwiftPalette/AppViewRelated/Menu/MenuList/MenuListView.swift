//
//  MenuListView.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class MenuListView: UIView {

    var viewModel: MenuListViewModel
    var navigationController: UINavigationController
    
    var tableView: UITableView!
    
    
    //MARK: - Initializers
    init(viewModel: MenuListViewModel, navigationController: UINavigationController) {
        
        self.viewModel = viewModel
        self.navigationController = navigationController
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Configuration
    func configureView() {
        self.backgroundColor = .secondarySystemBackground
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .secondarySystemBackground

        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


//MARK: - TableView Delegate and DataSource
extension MenuListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.labelText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myPalettesIndexPath = IndexPath(row: 0, section: 0)
        
        if myPalettesIndexPath == indexPath {
            navigationController.pushViewController(MyPalettesViewController(), animated: true)
        }
    }
}

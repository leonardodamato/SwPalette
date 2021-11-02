//
//  MenuListViewController.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class MenuListViewController: UIViewController {

    var menuListView: MenuListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMenuListView()
    }
    
    
    func configureMenuListView() {
        menuListView = MenuListView(viewModel: MenuListViewModel(), navigationController: navigationController!)
        view = menuListView
    }
}

//
//  PaletteView.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import UIKit

class PaletteView: UIView {
    
    var viewModel: PaletteViewModel
    
    var isTopColorDark: Bool = false

    //MARK: - UI Elements
    
    var topColor: UIColor?
    var tableView: ContentSizedTableView!
    var logo: UIImageView!
    
    //MARK: - Initializers
    
    init(viewModel: PaletteViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Configuration
    
    func configureTableView() {
        tableView = ContentSizedTableView()
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.registerTableViewCells(for: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = false
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    func configureLogo() {
        logo = UIImageView()
        self.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let logoImage = isTopColorDark ? UIImage(named: "logo-white") : UIImage(named: "logo-black")
        
        logo.image = logoImage
        
        logo.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            logo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            logo.heightAnchor.constraint(equalToConstant: 70),
            logo.widthAnchor.constraint(equalToConstant: 70)

        ])
    }
}


//MARK: - TableView DataSource and Delegate

extension PaletteView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let palette = viewModel.palette.value else { return 0 }
        
        return palette.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let palette = viewModel.palette.value else { return UITableViewCell() }
        
        let color = palette.colors[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseId, for: indexPath) as! ColorCell
        cell.color = color
        cell.configureColorButton()
        
        /// Defines whethet the top color is light or dark
        ///
        if indexPath.row == 0 {
            let uiColor = HexToUIColor.convert(hex: color)
            isTopColorDark = uiColor.isDarkColor
            configureLogo()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let palette = viewModel.palette.value else { return 0 }
        return tableView.frame.height / CGFloat(palette.colors.count)
    }
}

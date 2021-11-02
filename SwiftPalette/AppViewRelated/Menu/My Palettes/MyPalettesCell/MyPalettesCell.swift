//
//  MyPalettesCell.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class MyPalettesCell: UITableViewCell {

    var viewModel: MyPalettesCellViewModel?
    
    var container: UIView!
    var colorsStackView: UIStackView!
    var titleAndAuthorStackView: UIStackView!
    var paletteTitleLabel: UILabel!
    var paletteAuthorLabel: UILabel!
    
    func configure() {
        guard viewModel != nil else { return }
        
        contentView.backgroundColor = .secondarySystemBackground

        configureContainer()

        configureStackView()
        configurePaletteTitleLabel()
        configurePaletteAuthorLabel()
        configureTitleAndAuthorStackView()
        
        
        
    }
    
    func configureContainer() {
        container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureStackView() {
        guard let viewModel = viewModel else { return }

        colorsStackView = UIStackView()
        container.addSubview(colorsStackView)
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        colorsStackView.axis = .horizontal
        colorsStackView.spacing = 0
        colorsStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            colorsStackView.topAnchor.constraint(equalTo: container.topAnchor),
            colorsStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            colorsStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            colorsStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        for color in viewModel.colors {
            let uiColor = HexToUIColor.convert(hex: color)
            
            let view = UIView()
            view.backgroundColor = uiColor
            colorsStackView.addArrangedSubview(view)
        }
    }
    
    
    func configurePaletteTitleLabel() {
        guard let viewModel = viewModel else { return }
        
        paletteTitleLabel = UILabel()
        
        paletteTitleLabel.text = viewModel.title
        paletteTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func configurePaletteAuthorLabel() {
        guard let viewModel = viewModel else { return }
        
        paletteAuthorLabel = UILabel()
        
        paletteAuthorLabel.text = viewModel.author
        paletteAuthorLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    func configureTitleAndAuthorStackView() {
        
        titleAndAuthorStackView = UIStackView()
        container.addSubview(titleAndAuthorStackView)
        titleAndAuthorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleAndAuthorStackView.axis = .vertical
        titleAndAuthorStackView.spacing = 2
        titleAndAuthorStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            titleAndAuthorStackView.topAnchor.constraint(equalTo: colorsStackView.bottomAnchor, constant: 10),
            titleAndAuthorStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            titleAndAuthorStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            titleAndAuthorStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        
        titleAndAuthorStackView.addArrangedSubview(paletteTitleLabel)
        titleAndAuthorStackView.addArrangedSubview(paletteAuthorLabel)
    }
}

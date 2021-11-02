//
//  NavBarTitleView.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-26.
//

import UIKit

class NavBarTitleView: UIView {

    var viewModel: NavBarTitleViewModel
    
    var stackView: UIStackView!
    var paletteTitleLabel: UILabel!
    var paletteAuthorLabel: UILabel!
    
    init(viewModel: NavBarTitleViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configurePaletteTitleLabel()
        configurePaletteAuthorLabel()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureStackView() {
        stackView = UIStackView()
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        stackView.addArrangedSubview(paletteTitleLabel)
        stackView.addArrangedSubview(paletteAuthorLabel)

    }
    
    
    func configurePaletteTitleLabel() {
        paletteTitleLabel = UILabel()
        
        paletteTitleLabel.text = viewModel.paletteTitle
        
        //paletteTitleLabel.textColor = .systemRed
        paletteTitleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        paletteTitleLabel.textAlignment = .center
    }
    
    func configurePaletteAuthorLabel() {
        paletteAuthorLabel = UILabel()
        
        paletteAuthorLabel.text = viewModel.paletteAuthor
        
        //paletteAuthorLabel.textColor = .
        paletteAuthorLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        paletteAuthorLabel.textAlignment = .center
    }
}

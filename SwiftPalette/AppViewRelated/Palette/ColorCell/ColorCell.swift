//
//  ColorCell.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-24.
//

import UIKit

class ColorCell: UITableViewCell {

    static let reuseId = "ColorCell"
    
    var color: String?
    
    var colorButton: UIButton!
    var hexLabel: UILabel!
    var uiColorLabel: UILabel!
    
    var viewModel: ColorCellViewModel!
    
    var bgColor: UIColor {
        return HexToUIColor.convert(hex: viewModel.color)
    }
    
    func configureColorButton() {
        guard let color = color else { return }
        
        viewModel = ColorCellViewModel(color: color)
        
        colorButton = UIButton()
        contentView.addSubview(colorButton)
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        
        colorButton.addTarget(self, action: #selector(colorButtonDidTap(_:)), for: .touchUpInside)
        
        colorButton.backgroundColor = bgColor
        
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func overlayView() -> UIView {
        let view = UIView()
        view.frame = colorButton.frame
        
        /// Stack View Configuration
        ///
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        /// HEX Label Configuration
        ///
        hexLabel = UILabel()
        hexLabel.text = viewModel.hexColor
        
        //TODO: - CHANGE COLOR TO SUIT BG
        hexLabel.textColor = viewModel.setTintColor(for: bgColor)
        hexLabel.textAlignment = .center
        
        
        /// UIColor Label Configuration
        ///
        uiColorLabel = UILabel()
        uiColorLabel.text = viewModel.uiColor
        
        //TODO: - CHANGE COLOR TO SUIT BG
        uiColorLabel.textColor = viewModel.setTintColor(for: bgColor)
        uiColorLabel.textAlignment = .center
        uiColorLabel.adjustsFontSizeToFitWidth = true
        
        ///Add Arranged Subviews
        ///
        stackView.addArrangedSubview(hexLabel)
        stackView.addArrangedSubview(uiColorLabel)
        stackView.addArrangedSubview(configureCopyButtons())
        
        return view
    }
    
    func configureCopyButtons() -> UIStackView{
        /// Stack View Configuration
        ///
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
    
        /// Copy Hex Button
        ///
        let copyHexButton = UIButton()
        
        copyHexButton.setTitle(viewModel.copyHexButtonText, for: .normal)
        
        //TODO: - CHANGE COLOR TO SUIT BG
        copyHexButton.backgroundColor = viewModel.setTintColor(for: bgColor)
        copyHexButton.setTitleColor(bgColor, for: .normal)
        
        copyHexButton.titleLabel?.font = .systemFont(ofSize: 13)
        
        copyHexButton.layer.cornerRadius = 15
        
        copyHexButton.addTarget(self, action: #selector(copyHEX), for: .touchUpInside)
        
        
        /// Copy Hex Button
        ///
        let copyUIColorButton = UIButton()
        
        copyUIColorButton.setTitle(viewModel.copyUIColorButtonText, for: .normal)
        
        //TODO: - CHANGE COLOR TO SUIT BG
        copyUIColorButton.backgroundColor = viewModel.setTintColor(for: bgColor)
        copyUIColorButton.setTitleColor(bgColor, for: .normal)
        
        copyUIColorButton.titleLabel?.font = .systemFont(ofSize: 13)

        
        copyUIColorButton.layer.cornerRadius = 15
        
        copyUIColorButton.addTarget(self, action: #selector(copyUIColor), for: .touchUpInside)

        
        
        ///Add Arranged Subviews
        ///
        stackView.addArrangedSubview(copyHexButton)
        stackView.addArrangedSubview(copyUIColorButton)
        
        return stackView
    }
    
    
    @objc func colorButtonDidTap(_ sender: UIButton) {
        let view = overlayView()
        view.frame = sender.frame
        sender.addSubview(view)
        
        let seconds = viewModel.secondsShowingColorInformation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            view.removeFromSuperview()
        }
    }
    
    
    @objc func copyHEX() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = hexLabel.text ?? ""
    }
    
    
    @objc func copyUIColor() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = uiColorLabel.text ?? ""
    }
}

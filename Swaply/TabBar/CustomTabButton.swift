//
//  CustomTabButton.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

final class CustomTabButton: UIButton {
    
    private let imageViewCustom = UIImageView()
    private let titleLabelCustom = UILabel()
    private let selectionBackground = UIView()
    private let verticalStack = UIStackView()
    
    var tabItem: TabBarItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomViews() {
        backgroundColor = .clear
        
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.spacing = 2
        verticalStack.isUserInteractionEnabled = false
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewCustom.contentMode = .scaleAspectFit
        imageViewCustom.tintColor = UIColor.white.withAlphaComponent(0.6)
        imageViewCustom.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelCustom.font = AppTypography.caption1
        titleLabelCustom.textColor = UIColor.white.withAlphaComponent(0.6)
        titleLabelCustom.textAlignment = .center
        titleLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        
        selectionBackground.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        selectionBackground.layer.cornerRadius = 24
        selectionBackground.isHidden = true
        selectionBackground.isUserInteractionEnabled = false
        selectionBackground.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.addArrangedSubview(imageViewCustom)
        verticalStack.addArrangedSubview(titleLabelCustom)
        addSubview(selectionBackground)
        addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            selectionBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectionBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionBackground.widthAnchor.constraint(equalToConstant: 72),
            selectionBackground.heightAnchor.constraint(equalToConstant: 52),
            
            verticalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageViewCustom.widthAnchor.constraint(equalToConstant: 24),
            imageViewCustom.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with item: TabBarItem) {
        tabItem = item
        titleLabelCustom.text = item.title
        setNormalState()
    }
    
    func setSelectedState() {
        guard let item = tabItem else { return }
        imageViewCustom.image = item.selectedImage?.withRenderingMode(.alwaysTemplate)
        imageViewCustom.tintColor = AppColors.accentColor
        titleLabelCustom.textColor = AppColors.accentColor
        selectionBackground.isHidden = false
    }
    
    func setNormalState() {
        guard let item = tabItem else { return }
        imageViewCustom.image = item.defaultImage?.withRenderingMode(.alwaysTemplate)
        imageViewCustom.tintColor = UIColor.white.withAlphaComponent(0.6)
        titleLabelCustom.textColor = UIColor.white.withAlphaComponent(0.6)
        selectionBackground.isHidden = true
    }
}

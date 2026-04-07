//
//  CustomTabButton.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit
import SnapKit

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
        imageViewCustom.contentMode = .scaleAspectFit
        imageViewCustom.tintColor = UIColor.white.withAlphaComponent(0.6)
        titleLabelCustom.font = AppTypography.caption1
        titleLabelCustom.textColor = UIColor.white.withAlphaComponent(0.6)
        titleLabelCustom.textAlignment = .center
        selectionBackground.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        selectionBackground.layer.cornerRadius = 24
        selectionBackground.isHidden = true
        selectionBackground.isUserInteractionEnabled = false
        verticalStack.addArrangedSubview(imageViewCustom)
        verticalStack.addArrangedSubview(titleLabelCustom)
        addSubview(selectionBackground)
        addSubview(verticalStack)
        selectionBackground.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(52)
        }
        verticalStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        imageViewCustom.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
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

//
//  CustomTabButton.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit
import SnapKit

final class CustomTabButton: UIButton {

    // MARK: - Private Properties

    private lazy var imageViewCustom: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor.white.withAlphaComponent(0.6)
        return view
    }()

    private lazy var titleLabelCustom: UILabel = {
        let label = UILabel()
        label.font = AppTypography.caption1
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.textAlignment = .center
        return label
    }()

    private lazy var selectionBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        view.layer.cornerRadius = 24
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.isUserInteractionEnabled = false
        return stack
    }()

    // MARK: - Internal Properties

    var tabItem: TabBarItem?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomViews()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods

    private func setupCustomViews() {
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }
    private func setupSubviews() {
        verticalStack.addArrangedSubview(imageViewCustom)
        verticalStack.addArrangedSubview(titleLabelCustom)
        addSubview(selectionBackground)
        addSubview(verticalStack)
    }
    private func setupConstraints() {
        selectionBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(72)
            $0.height.equalTo(52)
        }
        verticalStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        imageViewCustom.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
    }

    // MARK: - Internal Methods

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

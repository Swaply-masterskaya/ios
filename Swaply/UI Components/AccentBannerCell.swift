//
//  AccentBannerCell.swift
//  Swaply
//
//  Created by Alina on 14/04/2026.
//

import UIKit
import SnapKit

final class AccentBannerCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private let containerView = UIView()

    private let logoImageView: UIImageView = {
        let image = UIImage(resource: .logoWhite)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = AppTypography.bodySemibold
        label.textColor = .white
        return label
    }()

    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGradient()
        setupConstraints()
    }

    @available(*, unavailable)
        required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
    }

    func configure(title: String, logo: UIImage?) {
        titleLabel.text = title
        logoImageView.image = logo
    }

    // MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(titleLabel)

        containerView.layer.cornerRadius = AppRadius.medium
        containerView.layer.masksToBounds = true
    }

    private func setupGradient() {
        gradientLayer.colors = [
            AppColors.gradientColor3.cgColor,
            AppColors.gradientColor2.cgColor,
            AppColors.gradientColor1.cgColor
        ]
        gradientLayer.locations = [0.0, 0.4423, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(232)
            make.height.equalTo(44)
        }
        containerView.layoutIfNeeded()
        gradientLayer.frame = containerView.bounds
    }
}

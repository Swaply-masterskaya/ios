//
//  AccentBannerCell.swift
//  Swaply
//
//  Created by Alina on 14/04/2026.
//

import UIKit
import SnapKit

final class AccentBannerCell: UICollectionViewCell {

    private enum Layout {
        static let contentInset: CGFloat = AppSpacing.large
        static let logoSize: CGFloat = 48
        static let logoTopInset: CGFloat = 64
        static let titleHeight: CGFloat = 44
    }

    // MARK: - Private Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = AppRadius.medium
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let image = UIImage(resource: .logoWhite)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = AppTypography.bodySemibold
        label.textColor = .white
        return label
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            AppColors.gradientColor3.cgColor,
            AppColors.gradientColor2.cgColor,
            AppColors.gradientColor1.cgColor
        ]
        layer.locations = [0.0, 0.4423, 1.0]
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        return layer
    }()

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

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let targetSize = CGSize(
            width: UIView.layoutFittingCompressedSize.width,
            height: layoutAttributes.size.height
        )
        let fittedSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )

        let attributes = layoutAttributes.copy() as? UICollectionViewLayoutAttributes ?? layoutAttributes
        attributes.frame.size.width = ceil(fittedSize.width)
        return attributes
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
    }

    private func setupGradient() {
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.logoTopInset)
            make.trailing.equalToSuperview().inset(Layout.contentInset)
            make.width.height.equalTo(Layout.logoSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.contentInset)
            make.leading.equalToSuperview().inset(Layout.contentInset)
            make.trailing.equalTo(logoImageView.snp.leading).offset(-Layout.contentInset)
            make.height.equalTo(Layout.titleHeight)
        }

        containerView.layoutIfNeeded()
        gradientLayer.frame = containerView.bounds
    }
}

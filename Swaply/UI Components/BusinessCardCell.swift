//
//  BusinessCardCell.swift
//  Swaply
//
//  Created by Alina on 17/04/2026.
//

import UIKit
import SnapKit

final class BusinessCardCell: UICollectionViewCell {

    // MARK: - Constants
    private enum Layout {
        static let logoWidthMultiplier: CGFloat = 0.62
        static let favoriteBadgeSize: CGFloat = 52
        static let categoryBadgeHeight: CGFloat = 52
        static let socialIconSize: CGFloat = 34
        static let socialBadgeSize: CGFloat = 44
        static let maxIconsPerRow = 3
    }

    // MARK: - Private Properties
    private let containerView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.headline
        label.textColor = AppColors.white
        label.numberOfLines = 1
        return label
    }()

    private let collaborationTypeLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.footnote
        label.textColor = AppColors.grey200
        label.numberOfLines = 1
        return label
    }()

    private let socialRowsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = AppSpacing.medium
        return stackView
    }()

    private let brandImageContainerView = UIView()

    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let likeView = VisualEffectBadgeView(cornerStyle: .circle)

    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let categoryView = VisualEffectBadgeView(cornerStyle: .pill)

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.caption2
        label.textColor = AppColors.grey50
        label.numberOfLines = 1
        return label
    }()

    private var socialIconViews: [UIView] = []

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupContent()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        setupContent()
    }

    // MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(collaborationTypeLabel)
        containerView.addSubview(socialRowsStackView)
        containerView.addSubview(brandImageContainerView)

        brandImageContainerView.addSubview(brandImageView)
        brandImageContainerView.addSubview(likeView)
        brandImageContainerView.addSubview(categoryView)
        likeView.contentView.addSubview(likeImageView)
        categoryView.contentView.addSubview(categoryLabel)

        contentView.backgroundColor = .clear
        containerView.backgroundColor = AppColors.grey400
        containerView.layer.cornerRadius = AppRadius.large
        containerView.layer.masksToBounds = true

        brandImageContainerView.layer.cornerRadius = AppRadius.large
        brandImageContainerView.layer.masksToBounds = true
        brandImageContainerView.backgroundColor = AppColors.black900
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        brandImageContainerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Layout.logoWidthMultiplier)
        }

        brandImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        likeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppSpacing.large)
            make.trailing.equalToSuperview().inset(AppSpacing.large)
            make.size.equalTo(Layout.favoriteBadgeSize)
        }

        likeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }

        categoryView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(AppSpacing.large)
            make.height.equalTo(Layout.categoryBadgeHeight)
        }

        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: AppSpacing.small,
                left: AppSpacing.large,
                bottom: AppSpacing.small,
                right: AppSpacing.large
            ))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(AppSpacing.xxlarge)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-AppSpacing.medium)
        }

        collaborationTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppSpacing.medium)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-AppSpacing.medium)
        }

        socialRowsStackView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(AppSpacing.xxlarge)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-AppSpacing.medium)
        }
    }

    private func setupContent() {
        titleLabel.text = "WeGym"
        collaborationTypeLabel.text = "Бартер"
        brandImageView.image = AppImages.logoOrange
        categoryLabel.text = "Спорт"
        likeImageView.image = AppImages.iconLikeFilled.withRenderingMode(.alwaysOriginal)
        configureSocialIcons([
            AppImages.iconTiktok,
            AppImages.iconTelegram,
            AppImages.iconYoutube,
            AppImages.iconDzen,
            AppImages.iconInstagram
        ].compactMap { $0 })
    }

    private func configureSocialIcons(_ icons: [UIImage]) {
        socialRowsStackView.arrangedSubviews.forEach {
            socialRowsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        socialIconViews.removeAll()

        icons.chunked(into: Layout.maxIconsPerRow).forEach { rowIcons in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .leading
            rowStackView.spacing = AppSpacing.medium

            rowIcons.forEach { icon in
                let iconView = makeSocialIconView(image: icon)
                socialIconViews.append(iconView)
                rowStackView.addArrangedSubview(iconView)
            }

            socialRowsStackView.addArrangedSubview(rowStackView)
        }
    }

    private func makeSocialIconView(image: UIImage) -> UIView {
        let container = UIView()
        container.backgroundColor = AppColors.black900
        container.layer.cornerRadius = Layout.socialBadgeSize / 2
        container.layer.masksToBounds = true

        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)

        container.snp.makeConstraints { make in
            make.size.equalTo(Layout.socialBadgeSize)
        }

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Layout.socialIconSize)
        }

        return container
    }
}

private final class VisualEffectBadgeView: UIView {

    enum CornerStyle {
        case circle
        case pill
    }

    let contentView = UIView()

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let cornerStyle: CornerStyle

    init(cornerStyle: CornerStyle) {
        self.cornerStyle = cornerStyle
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        switch cornerStyle {
        case .circle:
            layer.cornerRadius = bounds.height / 2
        case .pill:
            layer.cornerRadius = bounds.height / 2
        }
    }

    private func setupUI() {
        layer.masksToBounds = true
        addSubview(blurView)
        addSubview(contentView)

        contentView.backgroundColor = .clear

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }

        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

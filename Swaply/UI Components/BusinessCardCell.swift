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
        static let cellWidth: CGFloat = 353
        static let cellHeight: CGFloat = 148
        static let titleLeadingInset: CGFloat = 16
        static let socialLeadingInset: CGFloat = 2.59
        static let titleTopInset: CGFloat = 12
        static let companyToCollaborationSpacing: CGFloat = 4
        static let collaborationToSocialSpacing: CGFloat = 32
        static let socialStackSize = CGSize(width: 80, height: 48)
        static let socialIconSize = CGSize(width: 38, height: 22)
        static let socialIconSpacing: CGFloat = 4
        static let maxIconsPerRow = 2
        static let brandImageLeading: CGFloat = 104.59
        static let brandImageSize = CGSize(width: 254.93560791015625, height: 252.03860473632812)
        static let socialToBrandSpacing: CGFloat = 22
        static let likeBadgeSize: CGFloat = 24
        static let likeIconSize = CGSize(width: 13.333333969116211, height: 11.442066192626953)
        static let likeTopInset: CGFloat = 12
        static let likeTrailingInset: CGFloat = 12
        static let categoryTrailingInset: CGFloat = 12
        static let categoryBottomInset: CGFloat = 12
        static let categoryBadgeSize = CGSize(width: 50, height: 21)
    }

    // MARK: - Private Properties
    private let containerView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.headline1
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
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.socialIconSpacing
        return stackView
    }()

    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColors.white
        return imageView
    }()

    private let likeView = VisualEffectBadgeView(
        cornerStyle: .circle,
        overlayColor: UIColor.black.withAlphaComponent(0.2)
    )

    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let categoryView = VisualEffectBadgeView(
        cornerStyle: .pill,
        overlayColor: UIColor.black.withAlphaComponent(0.2)
    )

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
        containerView.addSubview(brandImageView)
        containerView.addSubview(likeView)
        containerView.addSubview(categoryView)
        likeView.contentView.addSubview(likeImageView)
        categoryView.contentView.addSubview(categoryLabel)

        contentView.backgroundColor = .clear
        containerView.backgroundColor = AppColors.grey400
        containerView.layer.cornerRadius = AppRadius.large
        containerView.layer.masksToBounds = true

        brandImageView.layer.cornerRadius = AppRadius.large
        brandImageView.layer.masksToBounds = true
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        brandImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Layout.brandImageLeading)
            make.centerY.equalToSuperview()
            make.size.equalTo(Layout.brandImageSize)
        }

        likeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.likeTopInset)
            make.trailing.equalToSuperview().inset(Layout.likeTrailingInset)
            make.size.equalTo(Layout.likeBadgeSize)
        }

        likeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Layout.likeIconSize)
        }

        categoryView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Layout.categoryTrailingInset)
            make.bottom.equalToSuperview().inset(Layout.categoryBottomInset)
            make.size.equalTo(Layout.categoryBadgeSize)
        }

        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.titleTopInset)
            make.leading.equalToSuperview().inset(Layout.titleLeadingInset)
            make.trailing.lessThanOrEqualTo(brandImageView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }

        collaborationTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Layout.companyToCollaborationSpacing)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(brandImageView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }

        socialRowsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Layout.socialLeadingInset)
            make.top.equalTo(collaborationTypeLabel.snp.bottom).offset(Layout.collaborationToSocialSpacing)
            make.size.equalTo(Layout.socialStackSize)
            make.trailing.lessThanOrEqualTo(brandImageView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }
    }

    private func setupContent() {
        titleLabel.text = "WeGym"
        collaborationTypeLabel.text = "Бартер"
        brandImageView.image = nil
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
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = Layout.socialIconSpacing

            rowIcons.forEach { icon in
                let iconView = makeSocialIconView(image: icon)
                socialIconViews.append(iconView)
                rowStackView.addArrangedSubview(iconView)
            }

            while rowStackView.arrangedSubviews.count < Layout.maxIconsPerRow {
                let spacerView = UIView()
                spacerView.backgroundColor = .clear
                rowStackView.addArrangedSubview(spacerView)
            }

            socialRowsStackView.addArrangedSubview(rowStackView)
        }
    }

    private func makeSocialIconView(image: UIImage) -> UIView {
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.size.equalTo(Layout.socialIconSize)
        }
        return imageView
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
    private let overlayColor: UIColor

    init(cornerStyle: CornerStyle, overlayColor: UIColor = .clear) {
        self.cornerStyle = cornerStyle
        self.overlayColor = overlayColor
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

        contentView.backgroundColor = overlayColor

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

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
    enum Layout {
        static let socialStackSize = CGSize(width: 80, height: 48)
        static let socialIconSize = CGSize(width: 20, height: 20)
        static let instagramIconSize = CGSize(width: 24, height: 24)
        static let instagramIconOffset = CGPoint(x: -4, y: -2)
        static let brandImageLeading: CGFloat = 119
        static let brandImageSize = CGSize(width: 234, height: 148)
        static let socialToBrandSpacing: CGFloat = 22
        static let likeBadgeSize: CGFloat = 24
        static let likeIconSize = CGSize(width: 16, height: 16)
        static let categoryBadgeSize = CGSize(width: 50, height: 21)
    }

    enum SocialIconType {
        case tiktok
        case telegram
        case youtube
        case dzen
        case instagram
    }

    struct SocialIconConfiguration {
        let type: SocialIconType
        let image: UIImage
        let size: CGSize
        let offset: CGPoint
    }

    struct BusinessCardViewModel {
        let title: String
        let collaborationType: String
        let brandImage: UIImage?
        let category: String
        let isLiked: Bool
        let socialIconRows: [[SocialIconConfiguration]]
    }
    
    // MARK: - Private Properties
    private var isLiked = false
    private var onLikeTap: ((Bool) -> Void)?
    private let containerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.headline1
        label.textColor = AppColors.white
        label.numberOfLines = 2
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
        stackView.spacing = AppSpacing.small
        return stackView
    }()
    
    private let brandImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        return view
    }()
    
    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeView = VisualEffectBadgeView(
        cornerStyle: .circle,
        overlayColor: UIColor.black.withAlphaComponent(0.02)
    )
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let categoryView = VisualEffectBadgeView(
        cornerStyle: .pill,
        overlayColor: UIColor.black.withAlphaComponent(0.02)
    )
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.caption2
        label.textColor = AppColors.grey50
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private var socialIconViews: [UIView] = []
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(collaborationTypeLabel)
        containerView.addSubview(socialRowsStackView)
        containerView.addSubview(brandImageContainerView)
        containerView.addSubview(likeView)
        containerView.addSubview(categoryView)
        brandImageContainerView.addSubview(brandImageView)
        likeView.contentView.addSubview(likeImageView)
        categoryView.contentView.addSubview(categoryLabel)
        
        contentView.backgroundColor = .clear
        containerView.backgroundColor = AppColors.grey400
        containerView.layer.cornerRadius = AppRadius.large
        containerView.layer.masksToBounds = true
        
        brandImageContainerView.layer.cornerRadius = AppRadius.large
        brandImageContainerView.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeView.addGestureRecognizer(tapGesture)
        likeView.isUserInteractionEnabled = true
        updateLikeAppearance()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        brandImageContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Layout.brandImageLeading)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        brandImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(Layout.brandImageSize)
        }
        
        likeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppSpacing.medium)
            make.trailing.equalToSuperview().inset(AppSpacing.medium)
            make.size.equalTo(Layout.likeBadgeSize)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Layout.likeIconSize)
        }
        
        categoryView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppSpacing.medium)
            make.bottom.equalToSuperview().inset(AppSpacing.medium)
            make.height.equalTo(Layout.categoryBadgeSize.height)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(12)        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppSpacing.medium)
            make.leading.equalToSuperview().inset(AppSpacing.large)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }
        
        collaborationTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppSpacing.xsmall)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }
        
        socialRowsStackView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(AppSpacing.medium)
            make.size.equalTo(Layout.socialStackSize)
            make.trailing.lessThanOrEqualTo(brandImageContainerView.snp.leading).offset(-Layout.socialToBrandSpacing)
        }
    }
    
    @objc private func likeTapped() {
        isLiked.toggle()
        updateLikeAppearance()
        onLikeTap?(isLiked)
    }
    
    private func  updateLikeAppearance() {
        let imageName = isLiked ? AppImages.iconLikeFilled : AppImages.iconLike
        likeImageView.image = imageName.withRenderingMode(.alwaysOriginal)
    }
    
    private func configureSocialIcons(_ iconRows: [[SocialIconConfiguration]]) {
        socialRowsStackView.arrangedSubviews.forEach {
            socialRowsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        socialIconViews.removeAll()
        
        iconRows.forEach { rowIcons in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .leading
            rowStackView.spacing = AppSpacing.small
            
            rowIcons.enumerated().forEach { index, iconConfiguration in
                let iconView = makeSocialIconView(
                    image: iconConfiguration.image,
                    imageSize: iconConfiguration.size,
                    offset: iconConfiguration.offset
                )
                socialIconViews.append(iconView)
                rowStackView.addArrangedSubview(iconView)
                
                if index == rowIcons.count - 2,
                   rowIcons.last?.type == .instagram {
                    rowStackView.setCustomSpacing(AppSpacing.large, after: iconView)
                }
            }
            
            socialRowsStackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func makeSocialIconView(image: UIImage, imageSize: CGSize, offset: CGPoint) -> UIView {
        let containerView = UIView()
        
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        containerView.snp.makeConstraints { make in
            make.size.equalTo(Layout.socialIconSize)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(offset.x)
            make.centerY.equalToSuperview().offset(offset.y)
            make.size.equalTo(imageSize)
        }
        
        return containerView
    }
    
    // MARK: - Public Methods
    func configure(with model: BusinessCardViewModel, onLikeTap: ((Bool) -> Void)? = nil) {
        self.onLikeTap = onLikeTap
        
        titleLabel.text = model.title
        collaborationTypeLabel.text = model.collaborationType
        brandImageView.image = model.brandImage
        categoryLabel.text = model.category
        isLiked = model.isLiked
        updateLikeAppearance()
        
        configureSocialIcons(model.socialIconRows)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        collaborationTypeLabel.text = nil
        brandImageView.image = nil
        categoryLabel.text = nil
        likeImageView.image = nil
        isLiked = false
        onLikeTap = nil
        
        socialRowsStackView.arrangedSubviews.forEach {
            socialRowsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        socialIconViews.removeAll()
    }
}

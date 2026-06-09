//
//  CardCell.swift
//  Swaply
//
//  Created by Георгий on 27.04.2026.
//

import UIKit
import SnapKit
import RxSwift

final class CardCell: UICollectionViewCell {

    static let reuseIdentifier = "CardCell"

    // MARK: - Private Properties

    private var disposeBag = DisposeBag()
    private var viewModel: CardViewModelProtocol?

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.grey600
        view.layer.cornerRadius = AppRadius.large
        view.layer.masksToBounds = true
        return view
    }()

    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = AppColors.grey400
        return imgView
    }()

    private let firstTitleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = AppRadius.small
        view.layer.masksToBounds = true
        return view
    }()

    private let firstTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.caption2
        label.textColor = AppColors.textPrimary
        return label
    }()

    private let secondTitleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = AppRadius.small
        view.layer.masksToBounds = true
        return view
    }()

    private let secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.caption2
        label.textColor = AppColors.textPrimary
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTypography.bodyBold
        label.textColor = AppColors.textPrimary
        return label
    }()

    private let likeButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = AppRadius.extraMedium
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        viewModel = nil

        likeButton.removeAllActions(for: .touchUpInside)

        imageView.image = nil
        firstTitleLabel.text = nil
        secondTitleLabel.text = nil
        subtitleLabel.text = nil
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(firstTitleContainer)
        firstTitleContainer.addSubview(firstTitleLabel)
        containerView.addSubview(secondTitleContainer)
        secondTitleContainer.addSubview(secondTitleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(likeButtonContainer)
        likeButtonContainer.addSubview(likeButton)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        firstTitleContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(AppSpacing.medium)
            $0.leading.equalToSuperview().offset(AppSpacing.medium)
            $0.height.equalTo(AppSpacing.xxlarge)
        }

        firstTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(AppSpacing.small)
            $0.trailing.equalToSuperview().offset(-AppSpacing.small)
            $0.centerY.equalToSuperview()
        }

        secondTitleContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(AppSpacing.medium)
            $0.leading.equalTo(firstTitleContainer.snp.trailing).offset(AppSpacing.xsmall)
            $0.height.equalTo(AppSpacing.xxlarge)
        }

        secondTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(AppSpacing.small)
            $0.trailing.equalToSuperview().offset(-AppSpacing.small)
            $0.centerY.equalToSuperview()
        }

        likeButtonContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(AppSpacing.medium)
            $0.trailing.equalToSuperview().offset(-AppSpacing.medium)
            $0.width.height.equalTo(AppSpacing.xxlarge)
        }

        likeButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(AppSpacing.large)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(AppSpacing.medium)
            $0.trailing.lessThanOrEqualToSuperview().offset(-AppSpacing.medium)
            $0.bottom.equalToSuperview().offset(-AppSpacing.medium)
        }
    }

    private func bindLikeButton() {
        viewModel?.isLiked
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLiked in
                guard let self = self else { return }
                let likeImage = isLiked ? AppImages.iconLikeFilled : AppImages.iconLike
                let finalImage = likeImage.withRenderingMode(.alwaysTemplate)
                self.likeButton.setImage(finalImage, for: .normal)
                self.likeButton.tintColor = isLiked ? AppColors.accentColor : UIColor.white.withAlphaComponent(0.8)
            })
            .disposed(by: disposeBag)
    }
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = AppImages.logoOrange
            return
        }
        // Пока просто заглушка
        imageView.image = AppImages.logoOrange
    }

    // MARK: - Internal Methods

    func configure(with viewModel: CardViewModelProtocol) {
        self.viewModel = viewModel
        disposeBag = DisposeBag()

        likeButton.removeAllActions(for: .touchUpInside)

        likeButton.addAction(UIAction { [weak self] _ in
            self?.viewModel?.likeTapped()
        }, for: .touchUpInside)

        loadImage(from: viewModel.imageUrl)
        
        firstTitleLabel.text = viewModel.firstTitle
        secondTitleLabel.text = viewModel.secondTitle
        subtitleLabel.text = viewModel.subtitle
        subtitleLabel.isHidden = viewModel.subtitle == nil

        bindLikeButton()
    }
}

private extension UIButton {
    func removeAllActions(for controlEvents: UIControl.Event) {
        enumerateEventHandlers { action, _, event, _ in
            if event == controlEvents, let action = action {
                removeAction(action, for: controlEvents)
            }
        }
    }
}

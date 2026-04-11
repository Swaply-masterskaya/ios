//
//  ButtonWithImage.swift
//  Swaply
//
//  Created by Aleksandr Baliev on 07.04.2026.
//

import UIKit
import SnapKit

final class ButtonWithImage: UIButton {

    // MARK: - Constants
    private let titleText: String
    private var config = UIButton.Configuration.filled()

    // MARK: - Initializers
    init(height: CGFloat, titleText: String = "Новый") {
        self.titleText = titleText
        super.init(frame: .zero)
        setup(with: height)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods
    private func setup(with height: CGFloat) {
        setupBackgroundColor()
        setupImage()
        setupText()
        setupConstraints(with: height)
        configuration = config
    }

    private func setupBackgroundColor() {
        config.baseBackgroundColor = AppColors.buttonWithImNormal
        configurationUpdateHandler = { [weak self] button in
            var updatedConfig = button.configuration ?? self?.config
            switch button.state {
            case .highlighted:
                updatedConfig?.baseBackgroundColor = AppColors.buttonWithImPressed
            case .disabled:
                updatedConfig?.baseBackgroundColor = AppColors.buttonWithImDisActivated
            default:
                updatedConfig?.baseBackgroundColor = AppColors.buttonWithImNormal
            }
            button.configuration = updatedConfig
        }
    }

    private func setupImage() {
        config.image = AppImages.iconAddProject.withTintColor(.white, renderingMode: .alwaysOriginal)
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .small)
        config.imagePlacement = .leading
        config.imagePadding = AppSpacing.xxsmall
    }

    private func setupText() {
        config.title = titleText
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = AppTypography.subheadline
            return outgoing
        }
        config.titleAlignment = .center
    }

    private func setupConstraints(with height: CGFloat) {
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        config.contentInsets = NSDirectionalEdgeInsets(
            top: AppSpacing.xsmall,
            leading: AppSpacing.xmedium,
            bottom: AppSpacing.xsmall,
            trailing: AppSpacing.xmedium)
        config.background.cornerRadius = AppRadius.medium
    }
}

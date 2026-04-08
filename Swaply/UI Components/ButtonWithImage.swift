//
//  ButtonWithImage.swift
//  Swaply
//
//  Created by Aleksandr Baliev on 07.04.2026.
//

import UIKit
import SnapKit

private enum Constants {
    static let imagePadding: CGFloat = 3
    static let height: CGFloat = 28
    static let contentInsetTop: CGFloat = 4
    static let contentInsetBottom: CGFloat = 4
    static let contentInsetLeading: CGFloat = 10
    static let contentInsetTrailing: CGFloat = 10
}

final class ButtonWithImage: UIButton {

    // MARK: - Constants
    private let titleText: String
    private var config = UIButton.Configuration.filled()

    // MARK: - Initializers
    init(titleText: String = "Новый") {
        self.titleText = titleText
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.titleText = "Новый"
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private Methods
    private func setup() {
        setupBackgroundColor()
        setupImage()
        setupText()
        setupConstraints()
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
        config.imagePadding = Constants.imagePadding
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

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(Constants.height)
        }
        config.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.contentInsetTop,
            leading: Constants.contentInsetLeading,
            bottom: Constants.contentInsetBottom,
            trailing: Constants.contentInsetTrailing)
        config.background.cornerRadius = AppRadius.medium
    }
}

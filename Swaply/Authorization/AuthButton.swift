import UIKit

final class AuthButton: UIButton {

    enum ButtonView {
        case registrationView
        case entryView
        static let buttonHeight = 52
    }

    // MARK: - Constants
    private let buttonView: ButtonView
    private let title: String
    private let buttonHeight = ButtonView.buttonHeight
    private let action: UIAction

    // MARK: - Private Properties
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let colors = [
            AppColors.gradientColor1.cgColor,
            AppColors.gradientColor2.cgColor,
            AppColors.gradientColor3.cgColor
        ]
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        backgroundColor = .clear
        return gradientLayer
    }()

    // MARK: - Initializers
    init(title: String, buttonView: ButtonView = .registrationView, action: UIAction) {
        self.buttonView = buttonView
        self.title = title
        self.action = action
        super.init(frame: .zero)
        setupButton()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    override func layoutSubviews() {
        super.layoutSubviews()

        if gradientLayer.superlayer != nil {
            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = layer.cornerRadius
        }
    }

    // MARK: - Private Methods
    private func setupButton() {
        layer.cornerRadius = AppRadius.extraLarge
        layer.masksToBounds = true
        titleLabel?.font = AppTypography.accentButtonTitle
        setTitle(title, for: .normal)
        addAction(action, for: .touchUpInside)
        setTitleColor(AppColors.white, for: .normal)

        configureAppearance()
    }

    private func configureAppearance() {
        switch buttonView {
        case .registrationView:
            if gradientLayer.superlayer == nil {
                layer.insertSublayer(gradientLayer, at: 0)
            }
        case .entryView:
            gradientLayer.removeFromSuperlayer()
            layer.borderColor = AppColors.buttonDefaultDisabled.cgColor
            backgroundColor = AppColors.buttonDefaultDisabled
            return
        }
    }
}

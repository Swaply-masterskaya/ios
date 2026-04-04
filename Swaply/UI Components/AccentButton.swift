import UIKit

final class AccentButton: UIButton {

    enum ButtonView {
        case defaultView
        case secondaryView
        case plainView
    }

    // MARK: - Constants
    private let buttonView: ButtonView
    private let title: String

    // MARK: - Internal Properties
    override var isHighlighted: Bool {
        didSet {
            configureAppearance()
        }
    }

    override var isEnabled: Bool {
        didSet {
            configureAppearance()
        }
    }

    // MARK: - Initializers
    init(title: String, buttonView: ButtonView = .defaultView) {
        self.buttonView = buttonView
        self.title = title.isEmpty ? "Button" : title
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder: NSCoder) {
        self.buttonView = .defaultView
        self.title = "Button"
        super.init(coder: coder)
        setupButton()
    }

    // MARK: - Private Methods
    private func setupButton() {
        layer.cornerRadius = 24
        layer.masksToBounds = true
        titleLabel?.font = AppTypography.accentButtonTitle
        setTitle(title, for: .normal)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        translatesAutoresizingMaskIntoConstraints = false

        switch buttonView {
        case .defaultView:
            setTitleColor(.buttonDefaultDisabledTypography, for: .disabled)
            setTitleColor(.white, for: .highlighted)
            setTitleColor(.white, for: .normal)
        case .secondaryView:
            setTitleColor(.buttonSecondaryDisabled, for: .disabled)
            setTitleColor(.buttonSecondaryPressed, for: .normal)
            setTitleColor(.buttonDefaultNormal, for: .highlighted)
            backgroundColor = .clear
            layer.borderWidth = 1
        case .plainView:
            setTitleColor(.buttonAdditionalNormalTypography, for: .normal)
            backgroundColor = .buttonAdditionalNormal
        }

        configureAppearance()
    }

    private func configureAppearance() {
        switch buttonView {
        case .defaultView:
            if state == .disabled {
                backgroundColor = .buttonDefaultDisabled
            } else if state == .highlighted {
                backgroundColor = .buttonDefaultPressed
            } else {
                backgroundColor = .buttonDefaultNormal
            }
        case .secondaryView:
            if state == .disabled {
                layer.borderColor = AppColors.buttonSecondaryDisabled.cgColor
            } else if state == .highlighted {
                layer.borderColor = AppColors.buttonSecondaryPressed.cgColor
            } else {
                layer.borderColor = AppColors.buttonDefaultNormal.cgColor
            }
        case .plainView:
            return
        }
    }
}

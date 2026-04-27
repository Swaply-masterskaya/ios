import UIKit
import SnapKit



final class AuthorizationViewController: UIViewController {

    enum AuthorizationLayout {
        static let logoImageSize: CGFloat = 48
        static let buttonHeight: CGFloat = 52
    }

    // MARK: - Constants
    private let viewModel: AuthorizationViewModelProtocol
    private let videoBackgroundView = VideoBackgroundView()

    // MARK: - Private Properties
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var registerButton: UIButton = AuthButton(
        title: Resources.WelcomeScreen.registerButtonTitle,
        buttonView: .registrationView,
        action: UIAction { [weak self] _ in
            self?.viewModel.registerButtonTapped()
        }
    )

    private lazy var entryButton: UIButton = AuthButton(
        title: Resources.WelcomeScreen.enterButtonTitle,
        buttonView: .entryView,
        action: UIAction { [weak self] _ in
            self?.viewModel.entryButtonTapped()
        }
    )

    private lazy var stackOfButtons: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(registerButton)
        stack.addArrangedSubview(entryButton)
        stack.axis = .vertical
        stack.spacing = AppSpacing.medium
        stack.distribution = .fill
        return stack
    }()

    // MARK: - Initializers
    init(viewModel: AuthorizationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = AppColors.backgroundPrimary
        setupVideoBackgroundView()
        setupContentView()
        setupLogoImage()
        setupStackView()
    }

    private func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupVideoBackgroundView() {
        view.addSubview(videoBackgroundView)
        videoBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupLogoImage() {
        contentView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(AuthorizationLayout.logoImageSize)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AppSpacing.small)
        }
    }

    private func setupStackView() {
        contentView.addSubview(stackOfButtons)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(AuthorizationLayout.buttonHeight)
        }
        entryButton.snp.makeConstraints { make in
            make.height.equalTo(AuthorizationLayout.buttonHeight)
        }
        stackOfButtons.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(AppSpacing.xlarge)
            make.bottom.equalToSuperview().inset(AppSpacing.xxlarge)
        }
    }
}

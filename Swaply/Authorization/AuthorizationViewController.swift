import UIKit
import SnapKit

final class AuthorizationViewController: UIViewController {
    // MARK: - Private Properties
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Constants
    private let viewModel: AuthorizationViewModel
    
    // MARK: - Initializers
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = AppColors.backgroundPrimary
        setupLogoImage()
    }
    
    private func setupLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(67)
        }
    }
}


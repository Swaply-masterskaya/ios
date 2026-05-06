//
//  SplashViewController.swift
//  Swaply
//
//  Created by Alina on 14/04/2026.
//

import UIKit
import SnapKit

final class SplashViewController: BaseCoordinatingController {

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundPrimary
        view.addSubview(logoImageView)

        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-53)
            make.width.height.equalTo(80)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.coordinator?.finish()
        }
    }
}

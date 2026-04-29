//
//  BusinessCardPreviewViewController.swift
//  Swaply
//
//  Temporary screen for BusinessCardCell preview.
//

import UIKit
import SnapKit

final class BusinessCardPreviewViewController: UIViewController {

    private enum Layout {
        static let cardSize = CGSize(width: 353, height: 148)
    }

    private let businessCardCell = BusinessCardCell(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.backgroundPrimary
        view.addSubview(businessCardCell)
    }

    private func setupConstraints() {
        businessCardCell.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Layout.cardSize)
        }
    }
}

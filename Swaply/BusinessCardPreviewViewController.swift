//
//  BusinessCardPreviewViewController.swift
//  Swaply
//
//  Created by Codex on 17/04/2026.
//

import UIKit
import SnapKit

final class BusinessCardPreviewViewController: UIViewController {

    // MARK: - Constants
    private enum Layout {
        static let horizontalInset: CGFloat = 16
        static let topInset: CGFloat = 32
        static let cellHeight: CGFloat = 280
    }

    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(
            top: Layout.topInset,
            left: Layout.horizontalInset,
            bottom: 0,
            right: Layout.horizontalInset
        )

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BusinessCardCell.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
        return collectionView
    }()

    private static let cellReuseIdentifier = "BusinessCardCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundPrimary
        title = "Business Card Preview"

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension BusinessCardPreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(
            withReuseIdentifier: Self.cellReuseIdentifier,
            for: indexPath
        )
    }
}

extension BusinessCardPreviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - (Layout.horizontalInset * 2)
        return CGSize(width: width, height: Layout.cellHeight)
    }
}

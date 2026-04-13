//
//  DropdownCell.swift
//  Swaply
//
//  Created by Алина on 08.04.2026.
//

import UIKit
import SnapKit

final class DropdownCell: UITableViewCell {

	private enum Layout {
		static let checkboxCornerRadius: CGFloat = 3
		static let contentInset: CGFloat = 12
		static let checkboxSize: CGFloat = 24
	}

	// MARK: - Constants
	static let reuseIdentifier = "DropdownCell"

	// MARK: - Private Properties
	private lazy var checkboxImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = Layout.checkboxCornerRadius
		imageView.layer.masksToBounds = true
		return imageView
	}()

	private lazy var valueLabel: UILabel = {
		let label = UILabel()
		label.font = AppTypography.body
		label.textColor = AppColors.grey400
		return label
	}()

	private lazy var cellContent: UIStackView = {
		let cellContent = UIStackView(arrangedSubviews: [checkboxImageView, valueLabel])
		cellContent.axis = .horizontal
		cellContent.spacing = AppSpacing.small
		cellContent.alignment = .center
		return cellContent
	}()

	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		selectionStyle = .none
		backgroundColor = .clear
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods
	func configureCell(
		text: String,
		isSelected: Bool = false,
		iconType: DropdownIconType
	) {
		valueLabel.text = text
		valueLabel.textColor = isSelected ? AppColors.textPrimary : AppColors.grey400
		updateCheckBox(isSelected: isSelected, iconType: iconType)
	}

	// MARK: - Private Methods
	private func setupConstraints() {
		contentView.clipsToBounds = true
		contentView.addSubview(cellContent)

		cellContent.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(Layout.contentInset)
			$0.trailing.equalToSuperview().inset(Layout.contentInset)
			$0.centerY.equalToSuperview()
		}

		checkboxImageView.snp.makeConstraints {
			$0.width.equalTo(Layout.checkboxSize)
			$0.height.equalTo(Layout.checkboxSize)
		}
		contentView.backgroundColor = .clear
	}

	private func updateCheckBox(isSelected: Bool, iconType: DropdownIconType) {
		let imageName = isSelected ? iconType.selectedImageName : iconType.normalImageName
		checkboxImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
		checkboxImageView.tintColor = isSelected ? AppColors.secondaryOrange : AppColors.grey400
	}
}

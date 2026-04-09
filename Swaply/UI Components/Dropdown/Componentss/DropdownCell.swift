//
//  DropdownCell.swift
//  Swaply
//
//  Created by Алина on 08.04.2026.
//

import UIKit
import SnapKit

final class DropdownCell: UITableViewCell {

	// MARK: - Constants
	static let reuseIdentifier = "DropdownCell"

	// MARK: - Internal Properties
	private(set) lazy var checkboxImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 3
		imageView.layer.masksToBounds = true
		return imageView
	}()

	private(set) lazy var valueLabel: UILabel = {
		let label = UILabel()
		label.font = AppTypography.body
		label.textColor = AppColors.grey400
		return label
	}()

	private(set) lazy var cellContent: UIStackView = {
		let cellContent = UIStackView(arrangedSubviews: [checkboxImageView, valueLabel])
		cellContent.axis = .horizontal
		cellContent.spacing = 8
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

	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		return nil
	}

	// MARK: - Internal Methods
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
			$0.leading.equalToSuperview().inset(12)
			$0.trailing.equalToSuperview().inset(12)
			$0.centerY.equalToSuperview()
		}

		checkboxImageView.snp.makeConstraints {
			$0.width.equalTo(24)
			$0.height.equalTo(24)
		}
		contentView.backgroundColor = .clear
	}

	private func updateCheckBox(isSelected: Bool, iconType: DropdownIconType) {
		let imageName = isSelected ? iconType.selectedImageName : iconType.normalImageName
		checkboxImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
		checkboxImageView.tintColor = isSelected ? AppColors.secondaryOrange : AppColors.grey400
	}
}

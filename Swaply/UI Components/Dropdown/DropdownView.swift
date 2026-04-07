//
//  DropdownView.swift
//  Swaply
//
//  Created by Алина on 07.04.2026.
//

import UIKit
import SnapKit

final class DropdownView: UIView {

	private let maxVisibleRows = 7
	private let rowHeight: CGFloat = 50
	private var tableViewHeightConstraint: Constraint?

	private var items: [String] = [
		"Dropdown item one", "Dropdown item two", "Dropdown item three", "Dropdown item four",
		"Dropdown item five", "Dropdown item six", "Dropdown item seven", "Dropdown item eight",
	]

	private lazy var titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.text = "Label"
		titleLabel.font = AppTypography.subheadline
		titleLabel.textColor = AppColors.textPrimary
		titleLabel.numberOfLines = 1
		return titleLabel
	}()

	private lazy var dropdownView: UIView = {
		let dropdownView = UIView()
		dropdownView.backgroundColor = AppColors.backgroundPrimary
		dropdownView.layer.cornerRadius = AppRadius.medium
		let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
		return dropdownView
	}()

	private lazy var placeholderLabel: UILabel = {
		let placeholderLabel = UILabel()
		placeholderLabel.font = AppTypography.body
		placeholderLabel.text = "Dropdown text"
		placeholderLabel.numberOfLines = 1
		placeholderLabel.lineBreakMode = .byTruncatingTail
		return placeholderLabel
	}()

	private lazy var arrowImageView: UIImageView = {
		let arrowImageView = UIImageView()
		arrowImageView.image = AppImages.iconChevronDown
		arrowImageView.contentMode = .scaleAspectFit
		arrowImageView.tintColor = .white
		return arrowImageView
	}()

	private lazy var dropdownTableView: UITableView = {
		let dropdownTableView = UITableView()
		dropdownTableView.dataSource = self
		dropdownTableView.delegate = self
		dropdownTableView.separatorStyle = .none
		return dropdownTableView
	}()

	private lazy var dropdownItemContent: UIStackView = {
		let dropdownItemContent = UIStackView(arrangedSubviews: [dropdownView, dropdownTableView])
		dropdownItemContent.axis = .vertical
		dropdownItemContent.spacing = .zero
		dropdownItemContent.alignment = .fill
		dropdownItemContent.distribution = .fill
		return dropdownItemContent
	}()

	private lazy var dropdownContent: UIStackView = {
		let dropdownContent = UIStackView(arrangedSubviews: [titleLabel, dropdownItemContent])
		dropdownContent.axis = .vertical
		dropdownContent.spacing = 8
		dropdownContent.alignment = .fill
		dropdownContent.distribution = .fill
		return dropdownContent
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupViews() {
		addSubview(dropdownContent)
		dropdownView.addSubview(placeholderLabel)
		dropdownView.addSubview(arrowImageView)
	}

	private func setupConstraints() {
		dropdownContent.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		dropdownItemContent.snp.makeConstraints {
			$0.height.equalTo(48)
		}

	}

	@objc private func didTap() {
		//TO DO:
	}
}

extension DropdownView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell() // временная заглушка
	}
}

extension DropdownView: UITableViewDelegate {
	
}

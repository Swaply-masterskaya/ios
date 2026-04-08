//
//  DropdownView.swift
//  Swaply
//
//  Created by Алина on 07.04.2026.
//

import UIKit
import SnapKit

final class DropdownView: UIView {

	private var state: DropdownState = .normal {
		didSet {
			updateStyles()
		}
	}

	private let maxVisibleRows = 7
	private let rowHeight: CGFloat = 50
	private var tableViewHeightConstraint: Constraint?

	private var items: [String] = [
		"Dropdown item one", "Dropdown item two", "Dropdown item three", "Dropdown item four",
		"Dropdown item five", "Dropdown item six", "Dropdown item seven", "Dropdown item eight"
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
		dropdownView.addGestureRecognizer(tap)
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
		dropdownTableView.register(DropdownCell.self, forCellReuseIdentifier: DropdownCell.reuseIdentifier)
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

		dropdownView.snp.makeConstraints {
			$0.height.equalTo(48)
		}

		arrowImageView.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.centerY.equalToSuperview()
			$0.width.height.equalTo(20)
		}

		placeholderLabel.snp.makeConstraints {
			$0.leading.equalTo(dropdownView.snp.leading).offset(16)
			$0.centerY.equalToSuperview()
			$0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-8)
		}

		dropdownTableView.snp.makeConstraints {
			tableViewHeightConstraint = $0.height.equalTo(0).constraint
		}
	}

	private func dropdownStyle(for state: DropdownState) -> DropdownStyle {
		let base = DropdownStyle(
			titleFont: AppTypography.subheadline,
			titleColor: AppColors.textPrimary,
			dropDownBackgroundColor: AppColors.backgroundPrimary,
			placeholderFont: AppTypography.body,
			placeholderColor: AppColors.textPlaceholder,
			arrowTintColor: AppColors.white
		)

		switch state {
		case .normal:
			return base
		case .selected:
			return DropdownStyle(
				titleFont: base.titleFont,
				titleColor: base.titleColor,
				dropDownBackgroundColor: base.dropDownBackgroundColor,
				placeholderFont: base.placeholderFont,
				placeholderColor: AppColors.textPrimary,
				arrowTintColor: base.arrowTintColor
				)
		case .disabled:
			return DropdownStyle(
				titleFont: base.titleFont,
				titleColor: base.titleColor,
				dropDownBackgroundColor: base.dropDownBackgroundColor,
				placeholderFont: base.placeholderFont,
				placeholderColor: AppColors.textSecondary,
				arrowTintColor: AppColors.textSecondary
				)
		case .expanded:
			return DropdownStyle(
				titleFont: base.titleFont,
				titleColor: base.titleColor,
				dropDownBackgroundColor: base.dropDownBackgroundColor,
				placeholderFont: base.placeholderFont,
				placeholderColor: AppColors.textPrimary,
				arrowTintColor: base.arrowTintColor
				)
		}
	}

	private func updateStyles() {
		let style = dropdownStyle(for: state)
		titleLabel.font = style.titleFont
		titleLabel.textColor = style.titleColor
		dropdownView.backgroundColor = style.dropDownBackgroundColor
		placeholderLabel.font = style.placeholderFont
		placeholderLabel.textColor = style.placeholderColor
		arrowImageView.tintColor = style.arrowTintColor

		UIView.animate(withDuration: 0.2) {
			self.arrowImageView.transform = (self.state == .expanded)
			? CGAffineTransform(rotationAngle: .pi)
			: .identity
		}
	}

	func setState(_ newState: DropdownState) {
		guard state != newState else { return }
		state = newState
	}

	func setTitle(_ text: String) {
		titleLabel.text = text
	}

	func setPlaceholder(_ text: String) {
		placeholderLabel.text = text
	}

	func configureDropdown(
		title: String,
		placeholder: String,
		items: [String],
		state: DropdownState
	) {
		titleLabel.text = title
		placeholderLabel.text = placeholder
		self.items = items
		self.state = state
	}

	func setItems(_ items: [String]) {
		self.items = items
		dropdownTableView.reloadData()
	}

	private func calculateHeightTableView() -> CGFloat {
		let contentHeight = CGFloat(items.count) * rowHeight
		let maxHeight = CGFloat(maxVisibleRows) * rowHeight
		dropdownTableView.isScrollEnabled = items.count > maxVisibleRows
		return min(contentHeight, maxHeight)
	}

	@objc private func didTap() {
		guard state != .disabled else { return }

		let shouldExpand = state != .expanded
		state = shouldExpand ? .expanded : .normal

		let newHeight = shouldExpand ? calculateHeightTableView() : .zero
		tableViewHeightConstraint?.update(offset: newHeight)
	}
}

extension DropdownView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: DropdownCell.reuseIdentifier,
			for: indexPath
		) as? DropdownCell else {
			return UITableViewCell()
		}
		cell.configureCell(text: items[indexPath.row])
		return cell
	}
}

extension DropdownView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let selectedItem = items[indexPath.row]
		placeholderLabel.text = selectedItem
		state = .selected
		tableViewHeightConstraint?.update(offset: 0)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
}

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

	private var items: [String] = [] {
		didSet {
			dropdownTableView.reloadData()
		}
	}

	private let maxVisibleRows = 7
	private let rowHeight: CGFloat = 50
	private let customScrollIndicatorView = CustomScrollIndicatorView()

	private var tableViewHeightConstraint: Constraint?
	private var tableContainerHeightConstraint: Constraint?
	private var selectedIndexPath: IndexPath?

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
		dropdownView.layer.masksToBounds = true
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
		dropdownTableView.backgroundColor = .clear
		dropdownTableView.showsVerticalScrollIndicator = false
		dropdownTableView.bounces = false
		dropdownTableView.register(DropdownCell.self, forCellReuseIdentifier: DropdownCell.reuseIdentifier)
		return dropdownTableView
	}()

	private lazy var dropdownTableContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.backgroundPrimary
		view.layer.cornerRadius = AppRadius.medium
		view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		view.clipsToBounds = true
		return view
	}()

	private lazy var separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.backgroundSecondary
		return view
	}()

	private lazy var dropdownItemContent: UIStackView = {
		let dropdownItemContent = UIStackView(arrangedSubviews: [dropdownView, dropdownTableContainerView])
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
		setupConstraints()
		setupActions()
		updateStyles()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
		setupConstraints()
		setupActions()
		updateStyles()
	}

	private func setupViews() {
		addSubview(dropdownContent)
		dropdownView.addSubview(placeholderLabel)
		dropdownView.addSubview(arrowImageView)
		dropdownTableContainerView.addSubview(separatorView)
		dropdownTableContainerView.addSubview(dropdownTableView)
		dropdownTableContainerView.addSubview(customScrollIndicatorView)
	}

	private func setupConstraints() {
		dropdownContent.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		dropdownView.snp.makeConstraints {
			$0.height.equalTo(48)
		}

		placeholderLabel.snp.makeConstraints {
			$0.leading.equalTo(dropdownView.snp.leading).offset(16)
			$0.centerY.equalToSuperview()
			$0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-8)
		}

		arrowImageView.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.centerY.equalToSuperview()
			$0.width.height.equalTo(20)
		}

		dropdownTableContainerView.snp.makeConstraints {
			tableContainerHeightConstraint = $0.height.equalTo(0).constraint
		}

		separatorView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(1)
		}

		customScrollIndicatorView.snp.makeConstraints {
			$0.top.equalTo(separatorView.snp.bottom).offset(8)
			$0.trailing.equalToSuperview().inset(8)
			$0.bottom.equalToSuperview().inset(8)
			$0.width.equalTo(8)
		}

		dropdownTableView.snp.makeConstraints {
			$0.top.equalTo(separatorView.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview()
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
		dropdownTableContainerView.backgroundColor = style.dropDownBackgroundColor
		placeholderLabel.font = style.placeholderFont
		placeholderLabel.textColor = style.placeholderColor
		arrowImageView.tintColor = style.arrowTintColor

		if state == .expanded {
			dropdownView.layer.maskedCorners = [
				.layerMinXMinYCorner,
				.layerMaxXMinYCorner
			]
		} else {
			dropdownView.layer.maskedCorners = [
				.layerMinXMinYCorner,
				.layerMaxXMinYCorner,
				.layerMinXMaxYCorner,
				.layerMaxXMaxYCorner
			]
		}

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
	}

	private func calculateHeightTableView() -> CGFloat {
		let contentHeight = CGFloat(items.count) * rowHeight
		let maxHeight = CGFloat(maxVisibleRows) * rowHeight
		let shouldScroll = items.count > maxVisibleRows

		dropdownTableView.isScrollEnabled = shouldScroll
		customScrollIndicatorView.isHidden = !shouldScroll

		return min(contentHeight, maxHeight)
	}

	private func updateCustomScrollIndicator() {
		customScrollIndicatorView.updateIndicator(
			contentHeight: dropdownTableView.contentSize.height,
			visibleHeight: dropdownTableView.bounds.height,
			contentOffsetY: dropdownTableView.contentOffset.y
		)
	}

	private func setupActions() {
		customScrollIndicatorView.onScrollProgressChanged = { [weak self] progress in
			guard let self else { return }

			let contentHeight = self.dropdownTableView.contentSize.height
			let visibleHeight = self.dropdownTableView.bounds.height
			let maxOffsetY = contentHeight - visibleHeight
			guard maxOffsetY > 0 else { return }

			let targetOffsetY = progress * maxOffsetY
			self.dropdownTableView.setContentOffset(
				CGPoint(x: 0, y: targetOffsetY),
				animated: false
			)
		}
	}

	private func applySelection(at indexPath: IndexPath) {
		selectedIndexPath = indexPath
		placeholderLabel.text = items[indexPath.row]
		state = .selected
		dropdownTableView.reloadData()
		updateCollapsedState()
	}

	private func updateCollapsedState() {
		tableViewHeightConstraint?.update(offset: 0)
		tableContainerHeightConstraint?.update(offset: 0)
		customScrollIndicatorView.resetIndicatorState()
	}

	@objc private func didTap() {
		guard state != .disabled else { return }

		let shouldExpand = state != .expanded
		state = shouldExpand ? .expanded : .normal

		let newHeight = shouldExpand ? calculateHeightTableView() : .zero
		let containerHeight = shouldExpand ? newHeight + 1 : .zero

		tableViewHeightConstraint?.update(offset: newHeight)
		tableContainerHeightConstraint?.update(offset: containerHeight)

		layoutIfNeeded()
		dropdownTableView.layoutIfNeeded()

		if shouldExpand {
			updateCustomScrollIndicator()
		} else {
			updateCollapsedState()
		}
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
		cell.configureCell(
			text: items[indexPath.row],
			isSelected: indexPath == selectedIndexPath
		)
		return cell
	}
}

extension DropdownView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		applySelection(at: indexPath)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView === dropdownTableView else { return }
		updateCustomScrollIndicator()
	}
}

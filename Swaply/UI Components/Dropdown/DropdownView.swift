//
//  DropdownView.swift
//  Swaply
//
//  Created by Алина on 07.04.2026.
//

import UIKit
import SnapKit

final class DropdownView: UIView {

	private enum Layout {
		static let dropdownHeight: CGFloat = 48
		static let rowHeight: CGFloat = 50
		static let maxVisibleRows: Int = 7
		static let iconSize: CGFloat = 20
		static let scrollIndicatorWidth: CGFloat = 8
		static let separatorHeight: CGFloat = 1
		static let animationDuration: TimeInterval = 0.2
	}

	// MARK: - Constants
	private let maxVisibleRows = Layout.maxVisibleRows
	private let rowHeight: CGFloat = Layout.rowHeight
	private var placeholderText: String = "Dropdown text"
	private var iconType: DropdownIconType = .square

	// MARK: - Public Properties
	var onSelectionChanged: (([String]) -> Void)?

	// MARK: - Private Properties
	private let dropdownViewModel = DropdownViewModel()
	private let customScrollIndicatorView = CustomScrollIndicatorView()

	private var tableViewHeightConstraint: Constraint?
	private var tableContainerHeightConstraint: Constraint?

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
		dropdownContent.spacing = AppSpacing.small
		dropdownContent.alignment = .fill
		dropdownContent.distribution = .fill
		return dropdownContent
	}()

	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupConstraints()
		setupActions()
		updateStyles()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Internal Methods
	func configureDropdown(
		title: String,
		placeholder: String,
		items: [String],
		state: DropdownState,
		iconType: DropdownIconType = .square
	) {
		setTitle(title)
		setPlaceholder(placeholder)
		setItems(items)
		setState(state)
		self.iconType = iconType
		updateArrowIcon()
	}

	func setState(_ newState: DropdownState) {
		dropdownViewModel.setState(newState)
		updateStyles()
	}

	// MARK: - Private Methods
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
			$0.height.equalTo(Layout.dropdownHeight)
		}

		placeholderLabel.snp.makeConstraints {
			$0.leading.equalTo(dropdownView.snp.leading).offset(AppSpacing.large)
			$0.centerY.equalToSuperview()
			$0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-AppSpacing.small)
		}

		arrowImageView.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(AppSpacing.large)
			$0.centerY.equalToSuperview()
			$0.width.height.equalTo(Layout.iconSize)
		}

		dropdownTableContainerView.snp.makeConstraints {
			tableContainerHeightConstraint = $0.height.equalTo(0).constraint
		}

		separatorView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(Layout.separatorHeight)
		}

		customScrollIndicatorView.snp.makeConstraints {
			$0.top.equalTo(separatorView.snp.bottom).offset(AppSpacing.small)
			$0.trailing.equalToSuperview().inset(AppSpacing.small)
			$0.bottom.equalToSuperview().inset(AppSpacing.small)
			$0.width.equalTo(Layout.scrollIndicatorWidth)
		}

		dropdownTableView.snp.makeConstraints {
			$0.top.equalTo(separatorView.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview()
			tableViewHeightConstraint = $0.height.equalTo(0).constraint
		}
	}

	private func updateStyles() {
		let style = dropdownViewModel.dropdownStyle(for: dropdownViewModel.state)
		let isExpanded = dropdownViewModel.state == .expanded

		applyDropdownStyle(style)
		updateExpandedAppearance(isExpanded)
	}

	private func applyDropdownStyle(_ style: DropdownStyle) {
		titleLabel.font = style.titleFont
		titleLabel.textColor = style.titleColor
		dropdownView.backgroundColor = style.dropDownBackgroundColor
		dropdownTableContainerView.backgroundColor = style.dropDownBackgroundColor
		placeholderLabel.font = style.placeholderFont
		placeholderLabel.textColor = style.placeholderColor
		arrowImageView.tintColor = style.arrowTintColor
	}

	private func updateExpandedAppearance(_ isExpanded: Bool) {
		dropdownView.layer.maskedCorners = isExpanded
		? [
			.layerMinXMinYCorner,
			.layerMaxXMinYCorner
		]
		: [
			.layerMinXMinYCorner,
			.layerMaxXMinYCorner,
			.layerMinXMaxYCorner,
			.layerMaxXMaxYCorner
		]

		UIView.animate(withDuration: Layout.animationDuration) {
			self.arrowImageView.transform = isExpanded
			? CGAffineTransform(rotationAngle: .pi)
			: .identity
		}
	}

	private func setTitle(_ text: String) {
		titleLabel.text = text
	}

	private func setPlaceholder(_ text: String) {
		placeholderText = text
		placeholderLabel.text = text
	}

	func setItems(_ items: [String]) {
		dropdownViewModel.setItems(items)
		dropdownTableView.reloadData()
	}

	private func updateArrowIcon() {
		arrowImageView.image = iconType.arrowImage
	}

	private func calculateHeightTableView() -> CGFloat {
		let shouldScroll = dropdownViewModel.shouldEnableScroll(maxVisibleRows: maxVisibleRows)
		dropdownTableView.isScrollEnabled = shouldScroll
		customScrollIndicatorView.isHidden = !shouldScroll

		return dropdownViewModel.calculateTableHeight(
			rowHeight: rowHeight,
			maxVisibleRows: maxVisibleRows)
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
		dropdownViewModel.toggleSelection(
			at: indexPath,
			isMultipleSelectionEnabled: iconType.isMultipleSelectionEnabled
		)

		if iconType.isMultipleSelectionEnabled {
			dropdownTableView.reloadRows(at: [indexPath], with: .none)
		} else {
			dropdownTableView.reloadData()
		}

		onSelectionChanged?(dropdownViewModel.selectedItems())
	}

	private func updateCollapsedState() {
		tableViewHeightConstraint?.update(offset: 0)
		tableContainerHeightConstraint?.update(offset: 0)
		customScrollIndicatorView.resetIndicatorState()
	}

	private func updateSelectedItemsText() {
		placeholderLabel.text = dropdownViewModel.selectedItemsText() ?? placeholderText
	}

	@objc private func didTap() {
		guard let shouldExpand = dropdownViewModel.toggleState() else { return }
		updateStyles()

		let newHeight = shouldExpand ? calculateHeightTableView() : .zero
		let containerHeight = shouldExpand ? newHeight + Layout.separatorHeight : .zero

		tableViewHeightConstraint?.update(offset: newHeight)
		tableContainerHeightConstraint?.update(offset: containerHeight)

		layoutIfNeeded()
		dropdownTableView.layoutIfNeeded()

		if shouldExpand {
			placeholderLabel.text = placeholderText
			updateStyles()
			updateCustomScrollIndicator()
		} else {
			updateSelectedItemsText()
			updateCollapsedState()
			setState(dropdownViewModel.hasSelectedItems() ? .selected : .normal)
		}
	}
}
// MARK: - UITableViewDataSource
extension DropdownView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dropdownViewModel.items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: DropdownCell.reuseIdentifier,
			for: indexPath
		) as? DropdownCell else {
			return UITableViewCell()
		}
		cell.configureCell(
			text: dropdownViewModel.items[indexPath.row],
			isSelected: dropdownViewModel.isItemSelected(at: indexPath),
			iconType: iconType
		)
		return cell
	}
}
// MARK: - UITableViewDelegate
extension DropdownView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		applySelection(at: indexPath)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Layout.rowHeight
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView === dropdownTableView else { return }
		updateCustomScrollIndicator()
	}
}

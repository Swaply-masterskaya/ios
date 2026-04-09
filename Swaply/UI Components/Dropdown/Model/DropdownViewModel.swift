//
//  DropdownViewModel.swift
//  Swaply
//
//  Created by Алина on 09.04.2026.
//

import UIKit

final class DropdownViewModel {

	// MARK: - Private Properties
	private(set) var state: DropdownState = .normal
	private(set) var items: [String] = []

	// MARK: - Internal Methods
	func dropdownStyle(for state: DropdownState) -> DropdownStyle {
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

	func setState(_ newState: DropdownState) {
		guard state != newState else { return }
		state = newState
	}

	func setItems(_ items: [String]) {
		self.items = items
	}

	func calculateTableHeight(rowHeight: CGFloat, maxVisibleRows: Int) -> CGFloat {
		let contentHeight = CGFloat(items.count) * rowHeight
		let maxHeight = CGFloat(maxVisibleRows) * rowHeight
		return min(contentHeight, maxHeight)
	}

	func shouldEnableScroll(maxVisibleRows: Int) -> Bool {
		items.count > maxVisibleRows
	}

	func toggleState() -> Bool? {
		guard state != .disabled else { return nil }

		let shouldExpand = state != .expanded
		setState(shouldExpand ? .expanded : .normal)
		return shouldExpand
	}
}

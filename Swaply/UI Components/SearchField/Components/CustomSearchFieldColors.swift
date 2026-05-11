//
//  CustomSearchFieldColors.swift
//  Swaply
//
//  Created by Алина on 11.05.2026.
//

import UIKit

struct CustomSearchFieldColors {
	let backgroundColor: UIColor
	let textColor: UIColor
	let placeholderInactiveColor: UIColor
	let placeholderActiveColor: UIColor
	let searchIconColor: UIColor
	let filterIconColor: UIColor
	let closeIconColor: UIColor
	let cursorTintColor: UIColor

	init(
		backgroundColor: UIColor = AppColors.glaseBase,
		textColor: UIColor = AppColors.primary,
		placeholderInactiveColor: UIColor = AppColors.grey200,
		placeholderActiveColor: UIColor = AppColors.grey400,
		searchIconColor: UIColor = AppColors.grey400,
		filterIconColor: UIColor = AppColors.grey400,
		closeIconColor: UIColor = AppColors.white,
		cursorTintColor: UIColor = AppColors.accentOrange
	) {
		self.backgroundColor = backgroundColor
		self.textColor = textColor
		self.placeholderInactiveColor = placeholderInactiveColor
		self.placeholderActiveColor = placeholderActiveColor
		self.searchIconColor = searchIconColor
		self.filterIconColor = filterIconColor
		self.closeIconColor = closeIconColor
		self.cursorTintColor = cursorTintColor
	}
}

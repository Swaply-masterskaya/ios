//
//  DropdownIconType.swift
//  Swaply
//
//  Created by Алина on 09.04.2026.
//

import UIKit

enum DropdownIconType {
	case square
	case radio

	var normalImageName: String {
		switch self {
		case .square:
			return "square"
		case .radio:
			return "circle"
		}
	}

	var selectedImageName: String {
		switch self {
		case .square:
			return "checkmark.square.fill"
		case .radio:
			return "circle.inset.filled"
		}
	}

	var isMultipleSelectionEnabled: Bool {
		switch self {
		case .square:
			return true
		case .radio:
			return false
		}
	}

	var arrowImage: UIImage {
		switch self {
		case .square:
			return AppImages.iconChevronDown
		case .radio:
			return AppImages.iconChevronPopUp
		}
	}
}

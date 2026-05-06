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

	var normalImageName: UIImage? {
		switch self {
		case .square:
            return AppImages.iconSquare
		case .radio:
            return AppImages.iconCircle
		}
	}

	var selectedImageName: UIImage? {
		switch self {
		case .square:
            return AppImages.iconSquareSelected
		case .radio:
            return AppImages.iconRadioSelected
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

//
//  AppColors.swift
//  Swaply
//
//  Created by Владислав Абушенко on 31.03.2026.
//

import UIKit

enum AppColors {
    // Primary Colors
    static let primary = UIColor(resource: .fixedWhite)
    // Secondary Colors
    static let secondary = UIColor(resource: .grey200)
	static let secondaryOrange = UIColor(resource: .secondaryOrange)
    // Background Colors
    static let backgroundPrimary = UIColor(resource: .backgroundBlack)
    static let backgroundSecondary = UIColor(resource: .secondaryBg)
    static let backgroundTertiary = UIColor(resource: .tertiary)
    // Accent Color
    static let accentColor = UIColor(resource: .accent)
    // Gradient Color
    static let gradientColor1 = UIColor(resource: .gradient1)
    static let gradientColor2 = UIColor(resource: .gradient2)
    static let gradientColor3 = UIColor(resource: .gradient3)
    // Text Colors
    static let textPrimary = UIColor(resource: .fixedWhite)
    static let textSecondary = UIColor(resource: .grey200)
    static let textPlaceholder = UIColor(resource: .grey400)
    // Status Colors
    static let statusGreen = UIColor(resource: .swaplyGreen)
    static let statusRed = UIColor(resource: .swaplyRed)
    static let statusYellow = UIColor(resource: .swaplyYellow)
    // Base Colors
    static let black = UIColor(resource: .black900)
    static let white = UIColor(resource: .fixedWhite)
    static let white20 = UIColor(resource: .white20)
    static let black900 = UIColor(resource: .black900)
    static let grey600 = UIColor(resource: .grey600)
    static let grey400 = UIColor(resource: .grey400)
    static let grey200 = UIColor(resource: .grey200)
    static let grey50 = UIColor(resource: .grey50)
    // Button Colors
    static let buttonDefaultNormal = UIColor(resource: .buttonDefaultNormal)
    static let buttonDefaultPressed = UIColor(resource: .buttonDefaultPressed)
    static let buttonDefaultDisabled = UIColor(resource: .buttonDefaultDisabled)
    static let buttonDefaultDisabledTypography = UIColor(resource: .buttonDefaultDisabledTypography)

    static let buttonSecondaryPressed = UIColor(resource: .buttonSecondaryPressed)
    static let buttonSecondaryDisabled = UIColor(resource: .buttonSecondaryDisabled)

    static let buttonAdditionalNormal = UIColor(resource: .buttonAdditionalNormal)
    static let buttonAdditionalNormalTypography = UIColor(resource: .buttonAdditionalNormalTypography)

    /// Buttons with Image States background color
    static let buttonWithImNormal = UIColor(resource: .secondaryOrange)
    static let buttonWithImPressed = UIColor(resource: .accentOrange)
    static let buttonWithImDisActivated = UIColor(resource: .grey300)
}

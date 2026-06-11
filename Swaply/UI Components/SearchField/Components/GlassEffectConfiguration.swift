//
//  GlassEffectConfiguration.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit

struct GlassEffectConfiguration {

	let blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark
	let baseFillColor: UIColor
	let darkOverlayColor: UIColor = AppColors.blackPure.withAlphaComponent(0.4)
	let lightOverlayColor: UIColor = AppColors.glassLight.withAlphaComponent(0.08)
	let blurTintColor: UIColor = AppColors.blackPure.withAlphaComponent(0.04)

	let borderColor: UIColor = AppColors.white.withAlphaComponent(0.20)
	let borderWidth: CGFloat = 1

	let cornerRadius: CGFloat

	init(
		baseFillColor: UIColor = AppColors.glaseBase,
		cornerRadius: CGFloat
	) {
		self.baseFillColor = baseFillColor
		self.cornerRadius = cornerRadius
	}
}

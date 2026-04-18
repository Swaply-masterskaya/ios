//
//  GlassEffectView.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit
import SnapKit

final class GlassEffectView: UIView {

	private var configuration: GlassEffectConfiguration

	private lazy var blurView: UIVisualEffectView = {
		let blurView = UIVisualEffectView()
		return blurView
	}()

	private lazy var baseFillView: UIView = {
		let view = UIView()
		return view
	}()

	private lazy var darkOverlayView: UIView = {
		let darkView = UIView()
		return darkView
	}()

	private lazy var lightOverlayView: UIView = {
		let lightView = UIView()
		return lightView
	}()

	private lazy var blurTintView: UIView = {
		let view = UIView()
		return view
	}()

	init(configuration: GlassEffectConfiguration) {
		self.configuration = configuration
		super.init(frame: .zero)
		setupView()
		applyConfiguration()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	override func layoutSubviews() {
		super.layoutSubviews()
		applyCornerRadius()
	}

	private func setupView() {
		clipsToBounds = true

		addSubview(blurView)
		blurView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		blurView.contentView.addSubview(baseFillView)
		baseFillView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		blurView.contentView.addSubview(darkOverlayView)
		darkOverlayView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		blurView.contentView.addSubview(lightOverlayView)
		lightOverlayView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		blurView.contentView.addSubview(blurTintView)
		blurTintView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	private func applyConfiguration() {
		blurView.effect = UIBlurEffect(style: configuration.blurStyle)
		baseFillView.backgroundColor = configuration.baseFillColor
		darkOverlayView.backgroundColor = configuration.darkOverlayColor
		lightOverlayView.backgroundColor = configuration.lightOverlayColor
		blurTintView.backgroundColor = configuration.blurTintColor
		layer.borderColor = configuration.borderColor.cgColor
		layer.borderWidth = configuration.borderWidth
		applyCornerRadius()
	}

	private func applyCornerRadius() {
		layer.cornerRadius = configuration.cornerRadius
		layer.masksToBounds = true

		blurView.layer.cornerRadius = configuration.cornerRadius
		blurView.layer.masksToBounds = true
	}

	func update(configuration: GlassEffectConfiguration) {
		self.configuration = configuration
		applyConfiguration()
	}
}

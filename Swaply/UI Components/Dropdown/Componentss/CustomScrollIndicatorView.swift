//
//  CustomScrollIndicatorView.swift
//  Swaply
//
//  Created by Алина on 08.04.2026.
//

import UIKit
import SnapKit

final class CustomScrollIndicatorView: UIView {

	// MARK: - Constants
	private let thumbMinHeight: CGFloat = 8

	// MARK: - Internal Properties
	var onScrollProgressChanged: ((CGFloat) -> Void)?

	// MARK: - Private Properties
	private let scrollTrackView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.backgroundSecondary
		view.layer.cornerRadius = 4
		return view
	}()

	private let scrollThumbView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.backgroundTertiary
		view.layer.cornerRadius = 4
		view.isUserInteractionEnabled = true
		return view
	}()

	private var thumbTopConstraint: Constraint?
	private var thumbHeightConstraint: Constraint?

	private var currentThumbHeight: CGFloat = 16
	private var currentTrackHeight: CGFloat = .zero

	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		initializeComponents()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initializeComponents()
	}

	// MARK: - Internal Methods
	func updateIndicator(
		contentHeight: CGFloat,
		visibleHeight: CGFloat,
		contentOffsetY: CGFloat
	) {
		guard shouldShowIndicator(
			contentHeight: contentHeight,
			visibleHeight: visibleHeight
		) else {
			resetIndicatorState()
			return
		}

		layoutIfNeeded()
		let trackHeight = bounds.height
		guard trackHeight > 0 else { return }

		let thumbHeight = calculateThumbHeight(
			contentHeight: contentHeight,
			visibleHeight: visibleHeight,
			trackHeight: trackHeight
		)

		let progress = calculateScrollProgress(
			contentHeight: contentHeight,
			visibleHeight: visibleHeight,
			contentOffsetY: contentOffsetY
		)

		let thumbTop = calculateThumbTop(
			progress: progress,
			trackHeight: trackHeight,
			thumbHeight: thumbHeight
		)

		currentThumbHeight = thumbHeight
		currentTrackHeight = trackHeight

		updateThumbLayout(height: thumbHeight, top: thumbTop)
		showIndicator()
	}

	func resetIndicatorState() {
		isHidden = true
		currentThumbHeight = thumbMinHeight
		currentTrackHeight = .zero
		updateThumbLayout(height: thumbMinHeight, top: 0)
	}

	// MARK: - Private Methods
	private func initializeComponents() {
		setupViews()
		setupConstraints()
		setupGestures()
		isHidden = true
	}

	private func setupViews() {
		addSubview(scrollTrackView)
		scrollTrackView.addSubview(scrollThumbView)
	}

	private func setupConstraints() {
		scrollTrackView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		scrollThumbView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			thumbTopConstraint = $0.top.equalToSuperview().constraint
			thumbHeightConstraint = $0.height.equalTo(thumbMinHeight).constraint
		}
	}

	private func setupGestures() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleThumbPan(_:)))
		scrollThumbView.addGestureRecognizer(panGesture)
	}

	private func shouldShowIndicator(contentHeight: CGFloat, visibleHeight: CGFloat) -> Bool {
		contentHeight > visibleHeight && visibleHeight > 0
	}

	private func calculateThumbHeight(
		contentHeight: CGFloat,
		visibleHeight: CGFloat,
		trackHeight: CGFloat
	) -> CGFloat {
		max((visibleHeight / contentHeight) * trackHeight, thumbMinHeight)
	}

	private func calculateScrollProgress(
		contentHeight: CGFloat,
		visibleHeight: CGFloat,
		contentOffsetY: CGFloat
	) -> CGFloat {
		let maxOffsetY = contentHeight - visibleHeight
		return maxOffsetY > 0 ? max(contentOffsetY, 0) / maxOffsetY : 0
	}

	private func calculateThumbTop(
		progress: CGFloat,
		trackHeight: CGFloat,
		thumbHeight: CGFloat
	) -> CGFloat {
		let maxThumbOffset = trackHeight - thumbHeight
		return progress * maxThumbOffset
	}

	private func updateThumbLayout(height: CGFloat, top: CGFloat) {
		thumbHeightConstraint?.update(offset: height)
		thumbTopConstraint?.update(offset: top)
	}

	private func showIndicator() {
		isHidden = false
		layoutIfNeeded()
	}

	@objc private func handleThumbPan(_ gesture: UIPanGestureRecognizer) {
		guard currentTrackHeight > 0 else { return }

		let translation = gesture.translation(in: scrollTrackView)
		let currentTop = thumbTopConstraint?.layoutConstraints.first?.constant ?? 0
		let newTop = clampedThumbTop(
			currentTop: currentTop,
			translationY: translation.y
		)

		thumbTopConstraint?.update(offset: newTop)
		gesture.setTranslation(.zero, in: scrollTrackView)

		let progress = calculateDragProgress(for: newTop)
		onScrollProgressChanged?(progress)
	}

	private func clampedThumbTop(
		currentTop: CGFloat,
		translationY: CGFloat
	) -> CGFloat {
		let maxThumbOffset = currentTrackHeight - currentThumbHeight
		return min(max(currentTop + translationY, 0), maxThumbOffset)
	}

	private func calculateDragProgress(for thumbTop: CGFloat) -> CGFloat {
		let maxThumbOffset = currentTrackHeight - currentThumbHeight
		return maxThumbOffset > 0 ? thumbTop / maxThumbOffset : 0
	}
}

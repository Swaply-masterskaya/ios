//
//  CustomSearchStripe.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit
import SnapKit

final class CustomSearchStripe: UISearchBar {

	private enum Layout {
		static let iconSize: CGFloat = 24
		static let iconContainerSize: CGFloat = 44
		static let searchBarHeight: CGFloat = 48
		static let animationDuration: TimeInterval = 0.18
	}

	private enum Text {
		static let placeholder = "Поиск"
	}

	// MARK: - Public Properties
	weak var customDelegate: CustomSearchStripeDelegate?

	var searchText: String? {
		get { searchTextField.text }
		set {
			searchTextField.text = newValue
			updateOverlayState(animated: false)
		}
	}
	// MARK: - Private Properties
	private var overlayCenterXConstraint: Constraint?
	private var overlayLeadingConstraint: Constraint?

	private lazy var iconSearchView: UIImageView = {
		let imageView = UIImageView(
			frame: CGRect(
				x: 0,
				y: 0,
				width: Layout.iconSize,
				height: Layout.iconSize
			)
		)
		imageView.image = AppImages.iconSearch
		imageView.tintColor = AppColors.grey400
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var iconContainerView: UIView = {
		let container = UIView(
			frame: CGRect(
				x: 0,
				y: 0,
				width: Layout.iconContainerSize,
				height: Layout.iconContainerSize
			)
		)
		container.addSubview(iconSearchView)
		iconSearchView.frame = CGRect(
			x: AppSpacing.xmedium,
			y: AppSpacing.xmedium,
			width: Layout.iconSize,
			height: Layout.iconSize
		)
		container.isUserInteractionEnabled = true
		let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSearch))
		container.addGestureRecognizer(tap)
		return container
	}()

	private lazy var filterButton: UIButton = {
		let button = UIButton(type: .system)
		button.frame = CGRect(
			x: 0,
			y: 0,
			width: Layout.iconSize,
			height: Layout.iconSize
		)
		button.setImage(AppImages.iconFilter, for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = AppColors.grey400
		button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
		return button
	}()

	private lazy var overlayPlaceholderLabel: UILabel = {
		let label = UILabel()
		label.text = Text.placeholder
		label.textColor = AppColors.grey200
		label.font = AppTypography.body
		label.textAlignment = .center
		label.isUserInteractionEnabled = false
		return label
	}()

	private lazy var glassEffectView: GlassEffectView = {
		let view = GlassEffectView(
			configuration: GlassEffectConfiguration(cornerRadius: AppRadius.extraLarge)
		)
		view.isUserInteractionEnabled = false
		return view
	}()
	// MARK: - Override Properties
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: Layout.searchBarHeight)
	}
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupAppearance()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
	// MARK: - Override Methods
	override func layoutSubviews() {
		super.layoutSubviews()
		updateCornerRadius()
		updateOverlayState(animated: false)
	}
	// MARK: - Public Methods
	func clearSearchStripe() {
		text = ""
		resignFirstResponder()
	}
	// MARK: - Private Methods
	private func setupAppearance() {
		setupBehavior()
		setupStyle()
		setupPlaceholder()
	}

	private func setupStyle() {
		searchBarStyle = .minimal
		searchTextField.leftView = iconContainerView
		searchTextField.leftViewMode = .always
		searchTextField.tintColor = AppColors.accentOrange
		searchTextField.textColor = AppColors.primary
		searchTextField.backgroundColor = .clear
		searchTextField.borderStyle = .none
		searchTextField.clipsToBounds = true

		setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		backgroundImage = UIImage()

		searchTextField.insertSubview(glassEffectView, at: 0)
		glassEffectView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		searchTextField.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	private func setupPlaceholder() {
		searchTextField.placeholder = nil
		searchTextField.addSubview(overlayPlaceholderLabel)

		let leftInset = (searchTextField.leftView?.frame.maxX ?? Layout.iconContainerSize) + AppSpacing.small

		overlayPlaceholderLabel.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			overlayCenterXConstraint = $0.centerX.equalToSuperview().constraint
			overlayLeadingConstraint = $0.leading.equalToSuperview().offset(leftInset).constraint
		}

		overlayLeadingConstraint?.deactivate()

		setOverlayPosition(isEditing: false, isEmpty: true, animated: false)
	}

	private func setupBehavior() {
		searchTextField.autocapitalizationType = .none
		searchTextField.autocorrectionType = .no
		searchTextField.spellCheckingType = .no
		searchTextField.delegate = self
		showsCancelButton = false
		searchTextField.clearButtonMode = .never

		searchTextField.returnKeyType = .search
		searchTextField.enablesReturnKeyAutomatically = true

		searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
	}

	private func updateRightIconVisibility(isVisible: Bool) {
		searchTextField.rightView = isVisible ? filterButton : nil
		searchTextField.rightViewMode = isVisible ? .always : .never
	}

	private func setOverlayPosition(isEditing: Bool, isEmpty: Bool, animated: Bool) {
		let shouldBeCentered = isEmpty && !isEditing
		overlayCenterXConstraint?.isActive = shouldBeCentered
		overlayLeadingConstraint?.isActive = !shouldBeCentered

		let animations = {
			self.searchTextField.layoutIfNeeded()
		}

		if animated {
			UIView.animate(
				withDuration: Layout.animationDuration,
				delay: 0,
				options: .curveEaseOut,
				animations: animations
			)
		} else {
			animations()
		}
	}

	private func updateOverlayPlaceholderColor(isInactive: Bool) {
		overlayPlaceholderLabel.textColor = isInactive ? AppColors.grey200 : AppColors.grey400
	}

	private func updateOverlayState(animated: Bool) {
		let isEmpty = searchTextField.text?.isEmpty ?? true
		let isEditing = searchTextField.isFirstResponder
		let isInactive = isEmpty && !isEditing
		overlayPlaceholderLabel.isHidden = !isEmpty
		setOverlayPosition(isEditing: isEditing, isEmpty: isEmpty, animated: animated)
		searchTextField.textAlignment = isInactive ? .center : .left

		updateOverlayPlaceholderColor(isInactive: isInactive)
		updateRightIconVisibility(isVisible: isInactive)
	}

	private func updateCornerRadius() {
		let cornerRadius = searchTextField.bounds.height / 2

		searchTextField.layer.cornerRadius = cornerRadius
		searchTextField.layer.masksToBounds = true

		glassEffectView.update(
			configuration: GlassEffectConfiguration(
				cornerRadius: cornerRadius
			)
		)
	}

	@objc private func didTapFilterButton() {
		customDelegate?.customSearchStripeDidTapFilterButton(self)
	}

	@objc private func textDidChange() {
		updateOverlayState(animated: false)
	}

	@objc private func didTapSearch() {
		customDelegate?.customSearchStripeDidTapSearchIcon(self)
	}

}
// MARK: - UITextFieldDelegate
extension CustomSearchStripe: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		updateOverlayState(animated: true)
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		updateOverlayState(animated: true)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

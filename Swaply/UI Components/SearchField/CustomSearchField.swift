//
//  CustomSearchField.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit
import SnapKit

final class CustomSearchField: UIView {

	private enum Layout {
		static let controlSize: CGFloat = 48
	}

	weak var delegate: CustomSearchFieldDelegate?

	// MARK: - Public Properties
	var text: String {
		get { searchStripe.searchText ?? "" }
		set { searchStripe.searchText = newValue }
	}

	// MARK: - Private Properties
	private let searchStripe = CustomSearchStripe()

	private lazy var closeButton: UIButton = {
		var config = UIButton.Configuration.plain()
		config.image = AppImages.iconClose.withRenderingMode(.alwaysTemplate)
		config.baseForegroundColor = AppColors.white
		config.background.cornerRadius = AppRadius.extraLarge
		config.cornerStyle = .fixed

		config.contentInsets = NSDirectionalEdgeInsets(
			top: AppSpacing.medium,
			leading: AppSpacing.medium,
			bottom: AppSpacing.medium,
			trailing: AppSpacing.medium
		)

		let button = UIButton(configuration: config)
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
		return button
	}()

	private lazy var closeButtonGlassEffectView: GlassEffectView = {
		let view = GlassEffectView(
			configuration: GlassEffectConfiguration(cornerRadius: AppRadius.extraLarge)
		)
		view.isUserInteractionEnabled = false
		return view
	}()

	private lazy var container: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [searchStripe, closeButton])
		stack.axis = .horizontal
		stack.spacing = AppSpacing.small
		stack.alignment = .fill
		stack.distribution = .fill
		return stack
	}()

	// MARK: - Init
	override init( frame: CGRect = .zero) {
		super.init(frame: frame)
		setupView()
		setupHierarchy()
		setupLayout()
		setupPriorities()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Private Methods
	private func setupView() {
		backgroundColor = .clear
		searchStripe.delegate = self
		searchStripe.customDelegate = self
		closeButton.isHidden = true

		closeButtonGlassEffectView.update(
			configuration: GlassEffectConfiguration(
				baseFillColor: AppColors.backgroundTertiary,
				cornerRadius: AppRadius.extraLarge
			)
		)
	}

	private func setupHierarchy() {
		addSubview(container)
		closeButton.insertSubview(closeButtonGlassEffectView, at: .zero)
	}

	private func setupLayout() {
		container.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.height.equalTo(Layout.controlSize)
		}
		closeButton.snp.makeConstraints {
			$0.size.equalTo(Layout.controlSize)
		}
		closeButtonGlassEffectView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	private func setupPriorities() {
		searchStripe.setContentHuggingPriority(.defaultLow, for: .horizontal)
		searchStripe.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

		closeButton.setContentHuggingPriority(.required, for: .horizontal)
		closeButton.setContentCompressionResistancePriority(.required, for: .horizontal)
	}

	private func dismissKeyboard() {
		searchStripe.resignFirstResponder()
	}

	private func setCloseButtonVisible(_ isVisible: Bool) {
		closeButton.isHidden = !isVisible
	}

	private func performSearch() {
		dismissKeyboard()
		delegate?.customSearchFieldDidTapSearch(self, text: text)
	}

	@objc private func didTapCloseButton() {
		searchStripe.clearSearchStripe()
		setCloseButtonVisible(false)
		delegate?.customSearchFieldDidTapClose(self)
	}
}

// MARK: - UISearchBarDelegate
extension CustomSearchField: UISearchBarDelegate {

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		delegate?.customSearchField(self, didChangeText: searchText)
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		performSearch()
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		setCloseButtonVisible(true)
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		if text.isEmpty {
			setCloseButtonVisible(false)
		}
	}
}

// MARK: - CustomSearchStripeDelegate
extension CustomSearchField: CustomSearchStripeDelegate {

	func customSearchStripeDidTapSearchIcon(_ customSearchStripe: CustomSearchStripe) {
		performSearch()
	}

	func customSearchStripeDidTapFilterButton(_ customSearchStripe: CustomSearchStripe) {
		delegate?.customSearchFieldDidTapFilter(self)
	}
}

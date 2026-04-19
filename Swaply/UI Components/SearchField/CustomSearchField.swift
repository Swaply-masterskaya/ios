//
//  CustomSearchField.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit
import SnapKit

final class CustomSearchField: UIView {

	weak var delegate: CustomSearchFieldDelegate?

	var text: String {
		get { searchStripe.text ?? "" }
		set { searchStripe.text = newValue }
	}

	private let searchStripe = CustomSearchStripe()

	private lazy var closeButton: UIButton = {
		var config = UIButton.Configuration.plain()
		config.image = AppImages.iconClose.withRenderingMode(.alwaysTemplate)
		config.baseForegroundColor = AppColors.white
		config.background.cornerRadius = 24
		config.cornerStyle = .fixed

		config.contentInsets = NSDirectionalEdgeInsets(
			top: 12,
			leading: 12,
			bottom: 12,
			trailing: 12
		)

		let button = UIButton(configuration: config)
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
		return button
	}()

	private lazy var closeButtonGlassEffectView: GlassEffectView = {
		let view = GlassEffectView(
			configuration: GlassEffectConfiguration(cornerRadius: 24)
		)
		view.isUserInteractionEnabled = false
		return view
	}()

	private lazy var container: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [searchStripe, closeButton])
		stack.axis = .horizontal
		stack.spacing = 8
		stack.alignment = .fill
		stack.distribution = .fill
		return stack
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupHierarchy()
		setupLayout()
		setupPriorities()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	private func setupView() {
		backgroundColor = .clear
		searchStripe.delegate = self
		searchStripe.customDelegate = self
	}

	private func setupHierarchy() {
		addSubview(container)
		closeButton.insertSubview(closeButtonGlassEffectView, at: 0)
	}

	private func setupLayout() {
		container.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.height.equalTo(48)
		}
		closeButton.snp.makeConstraints {
			$0.size.equalTo(48)
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

	private func performSearch() {
		delegate?.customSearchFieldDidTapSearch(self, text: text)
	}

	@objc private func didTapCloseButton() {
		searchStripe.clearSearchStripe()
		delegate?.customSearchFieldDidTapClose(self)
	}
}

extension CustomSearchField: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		delegate?.customSearchField(self, didChangeText: searchText)
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		performSearch()
	}
}

extension CustomSearchField: CustomSearchStripeDelegate {
	func customSearchStripeDidTapSearchIcon(_ customSearchStripe: CustomSearchStripe) {
		performSearch()
	}
}

//
//  CustomSearchStripe.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import UIKit

final class CustomSearchStripe: UISearchBar {

	private let isSelected: Bool = true

	private lazy var iconSearchView: UIImageView = {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
		imageView.image = UIImage(systemName: "magnifyingglass")
		imageView.tintColor = AppColors.grey400
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var filterButton: UIButton = {
		let button = UIButton(type: .system)
		button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
		button.tintColor = AppColors.grey400
		button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupAppearance()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	private func setupAppearance() {
		setupBehavior()
		setupStyle()
		setupPlaceholder()
	}

	private func setupStyle(){
		searchTextField.leftView = iconSearchView
		searchTextField.leftViewMode = .always
		updateRightIconVisibility(isVisible: true)
	}

	private func setupPlaceholder(){
		placeholder = "Поиск"
		searchTextField.textAlignment = .center
	}

	private func setupBehavior(){
		searchTextField.autocapitalizationType = .none // автоматическая заглавная буква
		searchTextField.autocorrectionType = .no // автозамена слова
		searchTextField.spellCheckingType = .no // проверка орфографии
		showsCancelButton = false
	}
// иконка справа (скрывается и показывается)
	private func updateRightIconVisibility(isVisible: Bool){
		if isVisible {
			searchTextField.rightView = filterButton
			searchTextField.rightViewMode = .always
		} else {
			searchTextField.rightView = nil
			searchTextField.rightViewMode = .never
		}
	}
// тап по фильтру
	@objc private func didTapFilterButton(){

	}

}

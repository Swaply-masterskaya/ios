//
//  CustomTextField.swift
//  Swaply
//
//  Created by Владислав Абушенко on 9.04.2026.
//

import UIKit
import SnapKit
import RxSwift

final class CustomTextField: UIView {

    // MARK: - Public Properties
    var textObservable: Observable<String> {
        textSubject
    }

    // MARK: - Private Properties
    private let textSubject = PublishSubject<String>()
    private let textField = UITextField()

    // MARK: - Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupActions()
        setupPlaceholder(placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Public Methods
    func setText(_ text: String) {
        textField.text = text
    }

    func getText() -> String {
        textField.text ?? ""
    }

    // MARK: - Private Methods
    private func setupUI() {
        textField.borderStyle = .none
        textField.backgroundColor = AppColors.backgroundTertiary
        textField.layer.cornerRadius = AppRadius.medium
        textField.tintColor = AppColors.buttonWithImPressed

        textField.leftView = makePadding(AppSpacing.medium)
        textField.leftViewMode = .always
        textField.rightView = makePadding(AppSpacing.medium)
        textField.rightViewMode = .always

        textField.font = AppTypography.body
        textField.textColor = AppColors.white

        addSubview(textField)
    }

    private func setupConstraints() {
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupActions() {
        textField.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            textSubject.onNext(textField.text ?? "")
        }, for: .editingChanged)
    }

    private func setupPlaceholder(_ text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: AppColors.grey400,
                .font: AppTypography.body
            ]
        )
    }

    private func makePadding(_ width: CGFloat) -> UIView {
        UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
    }
}

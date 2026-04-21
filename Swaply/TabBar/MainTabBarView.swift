//
//  MainTabBarView.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit
import RxSwift
import SnapKit

protocol MainTabBarViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

final class MainTabBarView: UIView {

    // MARK: - Internal Properties

    weak var delegate: MainTabBarViewDelegate?

    // MARK: - Private Properties

    private var buttons: [CustomTabButton] = []
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = .clear
        stack.spacing = 0
        return stack
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(AppSpacing.large)
            $0.trailing.equalToSuperview().offset(-AppSpacing.large)
            $0.bottom.equalToSuperview().offset(0)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(containerView).offset(4)
            $0.leading.equalTo(containerView).offset(8)
            $0.trailing.equalTo(containerView).offset(-8)
            $0.bottom.equalTo(containerView).offset(-4)
        }
    }

    private func animateButtonTap(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                button.transform = .identity
            }
        }
    }

    // MARK: - Internal Methods

    func configure(with items: [TabBarItem]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()

        for (index, item) in items.enumerated() {
            let button = CustomTabButton()
            button.configure(with: item)
            button.tag = index

            button.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                let index = button.tag
                self.delegate?.didSelectTab(at: index)
                self.animateButtonTap(button)
            }, for: .touchUpInside)

            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        renderTab(at: 0)
    }

    func renderTab(at index: Int) {
        guard index < buttons.count else { return }
        for (i, button) in buttons.enumerated() {
            if i == index {
                button.setSelectedState()
            } else {
                button.setNormalState()
            }
        }
    }
}

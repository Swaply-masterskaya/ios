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
    weak var delegate: MainTabBarViewDelegate?
    private var buttons: [CustomTabButton] = []
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = .clear
        stack.spacing = 0
        return stack
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(AppSpacing.large)
            make.trailing.equalToSuperview().offset(-AppSpacing.large)
            make.bottom.equalToSuperview().offset(0)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(4)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(containerView).offset(-8)
            make.bottom.equalTo(containerView).offset(-4)
        }
    }
    func configure(with items: [TabBarItem]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        for (index, item) in items.enumerated() {
            let button = CustomTabButton()
            button.configure(with: item)
            button.tag = index
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
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
    @objc private func tabButtonTapped(_ sender: CustomTabButton) {
        let index = sender.tag
        delegate?.didSelectTab(at: index)
        animateButtonTap(sender)
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
}

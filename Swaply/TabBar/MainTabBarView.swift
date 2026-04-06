//
//  MainTabBarView.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

protocol MainTabBarViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

final class MainTabBarView: UIView {
    
    weak var delegate: MainTabBarViewDelegate?
    private var buttons: [CustomTabButton] = []
    private var activeIndex: Int = 0
    
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
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppSpacing.large),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppSpacing.large),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
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
        
        selectTab(at: 0)
    }
    
    func selectTab(at index: Int) {
        guard index < buttons.count else { return }
        
        for button in buttons {
            button.setNormalState()
        }
        
        buttons[index].setSelectedState()
        activeIndex = index
    }
    
    @objc private func tabButtonTapped(_ sender: CustomTabButton) {
        let index = sender.tag
        guard index != activeIndex else { return }
        selectTab(at: index)
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

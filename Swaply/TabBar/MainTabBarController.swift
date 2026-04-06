//
//  MainTabBarController.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let customTabBarView = MainTabBarView()
    private let tabBarItems: [TabBarItem] = TabBarItem.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        configureViewControllers()
        
        view.backgroundColor = AppColors.black900
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.isHidden = true
        
        let bottomSafeArea = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 58
        let bottomOffset: CGFloat = 8
        
        customTabBarView.frame = CGRect(
            x: 0,
            y: view.frame.height - tabBarHeight - bottomSafeArea - AppSpacing.xsmall,
            width: view.frame.width,
            height: tabBarHeight + AppSpacing.xsmall * 2
        )
        
        if let controllers = viewControllers {
            let inset = tabBarHeight + bottomSafeArea + AppSpacing.xsmall
            for vc in controllers {
                vc.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
            }
        }
    }
    
    private func setupCustomTabBar() {
        customTabBarView.delegate = self
        customTabBarView.configure(with: tabBarItems)
        view.addSubview(customTabBarView)
    }
    
    private func configureViewControllers() {
        var viewControllers: [UIViewController] = []
        
        for item in tabBarItems {
            let vc = createMockViewController(for: item)
            viewControllers.append(vc)
        }
        
        self.viewControllers = viewControllers
    }
    
    private func createMockViewController(for item: TabBarItem) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = AppColors.black900
        
        let label = UILabel()
        label.text = item.title
        label.textColor = AppColors.textPrimary
        label.font = AppTypography.titleMedium
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        
        return vc
    }
}

extension MainTabBarController: MainTabBarViewDelegate {
    func didSelectTab(at index: Int) {
        selectedIndex = index
    }
}

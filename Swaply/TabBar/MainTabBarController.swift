//
//  MainTabBarController.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit
import RxSwift
import SnapKit

final class MainTabBarController: UITabBarController {

    // MARK: - Private Properties

    private let customTabBarView = MainTabBarView()
    private let tabBarItems: [TabBarItem] = TabBarItem.allCases
    private let viewModel = MainTabBarViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        configureViewControllers()
        bindViewModel()
        view.backgroundColor = AppColors.black900
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.isHidden = true
        let bottomSafeArea = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 58
        customTabBarView.frame = CGRect(
            x: 0,
            y: view.frame.height - tabBarHeight - bottomSafeArea - AppSpacing.xsmall,
            width: view.frame.width,
            height: tabBarHeight + AppSpacing.xsmall * 2
        )
    }

    // MARK: - Private Methods

    private func setupCustomTabBar() {
        customTabBarView.delegate = self
        customTabBarView.configure(with: tabBarItems)
        view.addSubview(customTabBarView)
    }
    private func bindViewModel() {
        viewModel.selectedIndex
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                self?.selectedIndex = index
                self?.customTabBarView.renderTab(at: index)
            })
            .disposed(by: disposeBag)
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

        vc.view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
        }

        return vc
    }
}

extension MainTabBarController: MainTabBarViewDelegate {
    func didSelectTab(at index: Int) {
        viewModel.selectTab(at: index)
    }
}

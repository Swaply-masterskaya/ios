//
//  MainTabBarController.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit
import RxSwift
import SnapKit

final class MainTabBarController: UITabBarController, Coordinating {

    // MARK: - Internal Properties

    weak var coordinator: Coordinator?

    // MARK: - Private Properties

    private let customTabBarView = MainTabBarView()
    private let tabBarItems: [TabBarItem] = TabBarItem.allCases
    private let viewModel = MainTabBarViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
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
}

extension MainTabBarController: MainTabBarViewDelegate {
    func didSelectTab(at index: Int) {
        viewModel.selectTab(at: index)
    }
}

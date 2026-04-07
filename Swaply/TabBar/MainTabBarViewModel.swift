//
//  MainTabBarViewModel.swift
//  Swaply
//
//  Created by Георгий on 07.04.2026.
//

import Foundation

final class MainTabBarViewModel {
    @Published private(set) var selectedIndex: Int = 0
    func selectTab(at index: Int) {
        guard index >= 0 && index < TabBarItem.allCases.count else { return }
        selectedIndex = index
    }
}

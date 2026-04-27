//
//  MainTabBarViewModel.swift
//  Swaply
//
//  Created by Георгий on 07.04.2026.
//

import Foundation
import RxSwift

final class MainTabBarViewModel {

    // MARK: - Private Properties

    private let selectedIndexSubject = BehaviorSubject<Int>(value: 0)

    // MARK: - Internal Properties

    var selectedIndex: Observable<Int> {
        return selectedIndexSubject.asObservable()
    }

    // MARK: - Internal Methods

    func selectTab(at index: Int) {
        guard index >= 0 && index < TabBarItem.allCases.count else { return }
        selectedIndexSubject.onNext(index)
    }
}

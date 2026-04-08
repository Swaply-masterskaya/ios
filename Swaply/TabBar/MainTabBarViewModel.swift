//
//  MainTabBarViewModel.swift
//  Swaply
//
//  Created by Георгий on 07.04.2026.
//

import Foundation
import RxSwift

final class MainTabBarViewModel {
    private let selectedIndexSubject = BehaviorSubject<Int>(value: 0)
    var selectedIndex: Observable<Int> {
        return selectedIndexSubject.asObservable()
    }

    func selectTab(at index: Int) {
        guard index >= 0 && index < TabBarItem.allCases.count else { return }
        selectedIndexSubject.onNext(index)
    }
}

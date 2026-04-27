//
//  CardViewModel.swift
//  Swaply
//
//  Created by Георгий on 27.04.2026.
//

import UIKit
import RxSwift

protocol CardViewModelProtocol {
    var image: UIImage? { get }
    var firstTitle: String { get }
    var secondTitle: String { get }
    var subtitle: String? { get }
    var isLiked: Observable<Bool> { get }
    func likeTapped()
}

final class CardViewModel: CardViewModelProtocol {

    // MARK: - Internal Properties

    var image: UIImage? {
        return AppImages.logoOrange
    }

    var firstTitle: String {
        return model.firstTitle
    }

    var secondTitle: String {
        return model.secondTitle
    }

    var subtitle: String? {
        return model.subtitle
    }

    var isLiked: Observable<Bool> {
        return isLikedSubject.asObservable()
    }

    // MARK: - Private Properties

    private let model: CardModel
    private let isLikedSubject: BehaviorSubject<Bool>

    // MARK: - Initializers

    init(model: CardModel) {
        self.model = model
        self.isLikedSubject = BehaviorSubject(value: model.isLiked)
    }

    // MARK: - Internal Methods

    func likeTapped() {
        guard let currentValue = try? isLikedSubject.value() else { return }
        isLikedSubject.onNext(!currentValue)
    }
}

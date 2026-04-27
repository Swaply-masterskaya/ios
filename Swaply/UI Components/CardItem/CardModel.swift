//
//  CardModel.swift
//  Swaply
//
//  Created by Георгий on 27.04.2026.
//

import Foundation

struct CardModel {
    let id: String
    let imageUrl: String?
    let firstTitle: String
    let secondTitle: String
    let subtitle: String?
    let isLiked: Bool
}

extension CardModel {
    static let mock = CardModel(
        id: "1",
        imageUrl: nil,
        firstTitle: "Eda",
        secondTitle: "Eda",
        subtitle: "Miss you",
        isLiked: false
    )
}

//
//  VisualEffectBadgeView.swift
//  Swaply
//
//  Created by Alina on 29/04/2026.
//
import UIKit

final class VisualEffectBadgeView: UIView {

    enum CornerStyle {
        case circle
        case pill
    }

    let contentView = UIView()

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let cornerStyle: CornerStyle
    private let overlayColor: UIColor

    init(cornerStyle: CornerStyle, overlayColor: UIColor = .clear) {
        self.cornerStyle = cornerStyle
        self.overlayColor = overlayColor
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        switch cornerStyle {
        case .circle:
            layer.cornerRadius = bounds.height / 2
        case .pill:
            layer.cornerRadius = bounds.height / 2
        }
    }

    private func setupUI() {
        layer.masksToBounds = true
        addSubview(blurView)
        addSubview(contentView)

        blurView.alpha = 0.4
        contentView.backgroundColor = overlayColor

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

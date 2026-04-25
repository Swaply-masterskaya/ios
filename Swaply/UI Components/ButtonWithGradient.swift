//
//  GradientButton.swift
//  Swaply
//
//  Created by Aleksandr Baliev on 15.04.2026.
//

import UIKit

private enum Constants {
    static let startPoint: CGFloat = 2
    static let sizeForImage: CGFloat = 24
    static let sizeForThumb: CGFloat = 48
    // Описывает какую часть кнопки надо пройти, после которой ползунок автоматом "доедет"
    static let successForSwipe = 0.75
    // Ширина зоны плавного затухания/появления (в поинтах)
    static let textFadeDistance: CGFloat = 25
}

final class ButtonWithGradient: UIView {

    // MARK: - Constants
    private var thumbPosition = Constants.startPoint

    // MARK: - Private Properties
    private var isConfirmed = false
    private var actionHandler: (() -> Void)?

    // Установка блюра для дальнейшего наложения оверлея
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = AppRadius.extraLarge
        blurView.clipsToBounds = true
        return blurView
    }()

    // Оверлей(серый фон)
    private lazy var trackView: UIView = {
        let trackView = UIView()
        trackView.backgroundColor = .white20
        trackView.layer.cornerRadius = AppRadius.extraLarge
        trackView.clipsToBounds = true
        return trackView
    }()

    // Фон для установки градиента
    private lazy var fillView: UIView = {
        let fillView = UIView()
        fillView.frame = CGRect(
            x: Constants.startPoint,
            y: Constants.startPoint,
            width: Constants.sizeForThumb,
            height: Constants.sizeForThumb
        )
        fillView.layer.cornerRadius = AppRadius.extraLarge
        fillView.clipsToBounds = true
        return fillView
    }()

    // Настройка ползунка
    private lazy var thumbView: UIView = {
        let thumbView = UIView()
        thumbView.backgroundColor = .clear
        thumbView.layer.cornerRadius = AppRadius.extraLarge
        thumbView.clipsToBounds = true
        thumbView.frame = CGRect(
            x: Constants.startPoint,
            y: Constants.startPoint,
            width: Constants.sizeForThumb,
            height: Constants.sizeForThumb
        )
        // Добавляем жест
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        thumbView.addGestureRecognizer(pan)
        return thumbView
    }()

    private lazy var iconView: UIImageView = {
        let image = AppImages.iconArrowForSlider.withRenderingMode(.alwaysOriginal)
        let iconView = UIImageView(image: image)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(
            x: AppSpacing.medium,
            y: AppSpacing.medium,
            width: Constants.sizeForImage,
            height: Constants.sizeForImage
        )
        return iconView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = Resources.Common.respondButtonTitle
        label.textColor = .white
        label.font = AppTypography.body
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()

    private lazy var fillGradientLayer: CAGradientLayer = {
        let fillGradientLayer = CAGradientLayer()
        let colors = [
            AppColors.gradientColor1.cgColor,
            AppColors.gradientColor2.cgColor,
            AppColors.gradientColor3.cgColor
        ]

        fillGradientLayer.colors = colors
        fillGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        fillGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        fillView.backgroundColor = .clear
        fillGradientLayer.cornerRadius = fillView.layer.cornerRadius
        fillView.layer.insertSublayer(fillGradientLayer, at: 0)
        return fillGradientLayer
    }()

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Public Methods
    func addAction(_ handler: @escaping () -> Void) {
        self.actionHandler = handler
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        blurView.frame = bounds
        trackView.frame = bounds
        label.frame = bounds

        // При успешном свайпе устанавливаем полностью градиентный фон
        if isConfirmed {
            changeViewWhenIsConfirm()
        } else {
            changeViewWhenNotYetConfirm()
        }
        makeLabelFade()
        fillGradientLayer.frame = fillView.bounds
    }

    // MARK: - Private Methods
    private func setupViews() {
        let views = [blurView, trackView, fillView, thumbView, label, iconView]
        views.forEach { view in
            // Проверка на добавление картинки в ползунок
            view is UIImageView ? thumbView.addSubview(iconView) : addSubview(view)
        }
    }

    private func changeViewWhenIsConfirm() {
        thumbView.alpha = 0
        fillView.frame = bounds
        label.font = AppTypography.bodySemibold
    }

    private func changeViewWhenNotYetConfirm() {
        // Постепенно заполняем градиентным фоном
        let fillWidth = thumbPosition + Constants.sizeForThumb - 2
        fillView.frame = CGRect(
            x: Constants.startPoint,
            y: Constants.startPoint,
            width: max(0, fillWidth),
            height: Constants.sizeForThumb
        )
    }

    private func makeLabelFade() {
        let fadeDistance: CGFloat = Constants.textFadeDistance
        let textRect = label.textRect(forBounds: label.bounds, limitedToNumberOfLines: label.numberOfLines)
        let thumbCenter = thumbView.frame.midX

        if thumbCenter < textRect.minX - fadeDistance {
            label.alpha = 1
        } else if thumbCenter < textRect.minX {
            label.alpha = (textRect.minX - thumbCenter) / fadeDistance
        } else if thumbCenter <= textRect.maxX {
            label.alpha = 0
        } else if thumbCenter < textRect.maxX + fadeDistance {
            label.alpha = (thumbCenter - textRect.maxX) / fadeDistance
        } else {
            label.alpha = 1
        }
    }

    private func confirm() {
        isConfirmed = true
        thumbPosition = bounds.width - Constants.sizeForThumb - Constants.startPoint

        setNeedsLayout()
        layoutIfNeeded()

        actionHandler?()
    }

    private func reset() {
        isConfirmed = false
        thumbPosition = Constants.startPoint

        thumbView.frame = CGRect(
            x: Constants.startPoint,
            y: Constants.startPoint,
            width: Constants.sizeForThumb,
            height: Constants.sizeForThumb
        )
        fillView.frame = CGRect(
            x: Constants.startPoint,
            y: Constants.startPoint,
            width: Constants.sizeForThumb,
            height: Constants.sizeForThumb
        )
    }

    @objc private func handlePan(_ position: UIPanGestureRecognizer) {
        guard !isConfirmed else { return }

        // Создаем и дальше накапливаем поинты при движении ползунка
        let translation = position.translation(in: self)
        let minX: CGFloat = Constants.startPoint
        let maxX = bounds.width - Constants.sizeForThumb - Constants.startPoint

        switch position.state {
        case .changed:
            thumbPosition += translation.x
            thumbPosition = max(minX, min(thumbPosition, maxX))

            // Стартовая позиция ползунка
            thumbView.frame.origin.x = thumbPosition
            // Рассчитываем на сколько надо заполнить градиентным фоном
            let fillWidth = thumbPosition + Constants.sizeForThumb - Constants.startPoint
            fillView.frame.size.width = max(0, fillWidth)

            // Отменяем анимацию градиентного фона, чтобы он моментально двигался за ползунком
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            setNeedsLayout()
            layoutIfNeeded()
            CATransaction.commit()

            // Обнуляем накопление поинтов
            position.setTranslation(.zero, in: self)

        case .ended, .cancelled:
            // Если ползунок дотянули миниммум до 75% от всей длины кнопки, то он автоматом дотягивается и получаем успешный свайп, иначе переходим в начальное положение
            if thumbPosition > bounds.width * Constants.successForSwipe {
                confirm()
            } else {
                reset()
            }
        default:
            break
        }
    }
}

import UIKit

final class ProgressView: UIView {

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
            AppColors.gradientColor1.cgColor,
            AppColors.gradientColor2.cgColor,
            AppColors.gradientColor3.cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        return gradientLayer
    }()

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 8)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

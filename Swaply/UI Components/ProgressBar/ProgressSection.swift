import UIKit
import SnapKit

class ProgressSection: UIView {

    private let progressView = ProgressView()

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 8)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupUI() {
        backgroundColor = AppColors.grey600
        layer.cornerRadius = AppRadius.extraExtraSmall
        layer.masksToBounds = true

        addSubview(progressView)

        configureConstraints(multiplier: 0)
    }

    func configureConstraints(multiplier: Double) {
        UIView.animate(withDuration: 0.3) {
            self.progressView.snp.remakeConstraints {
                $0.leading.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(multiplier)
            }
            self.layoutIfNeeded()
        }
    }
}

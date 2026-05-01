import UIKit
import SnapKit

class ProgressSection: UIView {

    // MARK: - Private Properties
    private let progressView = ProgressView()

    // MARK: - Internal Properties
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 8)
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    func configureConstraints(multiplier: Double) {
        UIView.animate(withDuration: 0.3) {
            self.progressView.snp.remakeConstraints {
                $0.leading.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(multiplier)
            }
            self.layoutIfNeeded()
        }
    }

    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = AppColors.grey600
        layer.cornerRadius = AppRadius.extraExtraSmall
        layer.masksToBounds = true

        addSubview(progressView)

        configureConstraints(multiplier: 0)
    }
}

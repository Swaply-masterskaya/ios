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

        setupConstraints()
    }

    private func setupConstraints() {
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
    }

    func setWidthToZero() {
        UIView.animate(withDuration: 0.3) {
            self.progressView.snp.updateConstraints {
                $0.width.equalToSuperview().multipliedBy(0)
            }
            self.layoutIfNeeded()
        }
    }

    func setWidthToHalf() {
        UIView.animate(withDuration: 0.3) {
            self.progressView.snp.updateConstraints {
                $0.width.equalToSuperview().multipliedBy(0.5)
            }
            self.layoutIfNeeded()
        }
    }

    func setWidthToFull() {
        UIView.animate(withDuration: 0.3) {
            self.progressView.snp.updateConstraints {
                $0.width.equalToSuperview().multipliedBy(1)
            }
            self.layoutIfNeeded()
        }
    }
}

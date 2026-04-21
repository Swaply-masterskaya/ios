import UIKit
import SnapKit

final class ProgressBar: UIView {

    private lazy var progressSectionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = AppSpacing.small
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let numberOfSegments: Int
    private var currentProgressValue = 0.0

    init(numberOfSegments: Int) {
        self.numberOfSegments = numberOfSegments
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupUI() {
        for _ in 0 ..< numberOfSegments {
            progressSectionsStackView.addArrangedSubview(ProgressSection())
        }

        addSubview(progressSectionsStackView)

        setupConstraints()
    }

    private func setupConstraints() {
        progressSectionsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func getSection() -> ProgressSection? {
        let sectionIndex = Int(currentProgressValue)

        guard sectionIndex >= 0,
              sectionIndex < numberOfSegments,
              let currentProgressSection = progressSectionsStackView.arrangedSubviews[sectionIndex] as? ProgressSection else {
            return nil
        }

        return currentProgressSection
    }

    private func isWhole(_ number: Double) -> Bool {
        number.truncatingRemainder(dividingBy: 1) == 0
    }

    private func isInRange(value: Double) -> Bool {
        if value < 0 || value > Double(numberOfSegments) {
            return false
        } else {
            return true
        }
    }

    func completeHalfOfSection() {
        let isSectionEmpty = isWhole(currentProgressValue)

        guard let currentProgressSection = getSection() else {
            return
        }

        let newValue = currentProgressValue + 0.5

        guard isInRange(value: newValue) else {
            return
        }

        currentProgressValue = newValue

        if isSectionEmpty {
            currentProgressSection.setWidthToHalf()
        } else {
            currentProgressSection.setWidthToFull()
        }
    }

    func finishSection() {
        let isSectionEmpty = isWhole(currentProgressValue)

        guard let currentProgressSection = getSection() else {
            return
        }

        let newValue = currentProgressValue + (isSectionEmpty ? 1 : 0.5)

        guard isInRange(value: newValue) else {
            return
        }

        currentProgressValue = newValue

        currentProgressSection.setWidthToFull()
    }

    func cancelHalfOfSection() {
        let isSectionFull = isWhole(currentProgressValue)

        let newValue = currentProgressValue - 0.5

        guard isInRange(value: newValue) else {
            return
        }

        currentProgressValue = newValue

        guard let currentProgressSection = getSection() else {
            return
        }

        if isSectionFull {
            currentProgressSection.setWidthToHalf()
        } else {
            currentProgressSection.setWidthToZero()
        }
    }

    func cancelWholeSection() {
        let isSectionFull = isWhole(currentProgressValue)

        let newValue = currentProgressValue - (isSectionFull ? 1 : 0.5)

        guard isInRange(value: newValue) else {
            return
        }

        currentProgressValue = newValue

        guard let currentProgressSection = getSection() else {
            return
        }

        currentProgressSection.setWidthToZero()
    }
}

import UIKit
import SnapKit

final class ProgressBar: UIView {

    // MARK: - Private Properties
    private lazy var progressSectionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = AppSpacing.small
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let numberOfSections: Int
    private var currentProgressValue = 0.0

    // MARK: - Initializers
    init(numberOfSegments: Int) {
        self.numberOfSections = max(numberOfSegments, 1)
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
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

        currentProgressSection.configureConstraints(multiplier: isSectionEmpty ? 0.5 : 1)
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

        currentProgressSection.configureConstraints(multiplier: 1)
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

        currentProgressSection.configureConstraints(multiplier: isSectionFull ? 0.5 : 0)
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

        currentProgressSection.configureConstraints(multiplier: 0)
    }

    // MARK: - Private Methods
    private func setupUI() {
        for _ in 0 ..< numberOfSections {
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

        guard (0..<numberOfSections).contains(sectionIndex),
              let currentProgressSection = progressSectionsStackView.arrangedSubviews[sectionIndex] as? ProgressSection else {
            return nil
        }

        return currentProgressSection
    }

    private func isWhole(_ number: Double) -> Bool {
        number.truncatingRemainder(dividingBy: 1) == 0
    }

    private func isInRange(value: Double) -> Bool {
        (0...Double(numberOfSections)).contains(value) ? true : false
    }
}

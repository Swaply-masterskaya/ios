import UIKit

final class PageControl: UIPageControl {

    init(numberOfPages: Int) {
        super.init(frame: .zero)
        self.numberOfPages = max(0, numberOfPages)
        setupPageControl()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupPageControl() {
        currentPage = 0
        currentPageIndicatorTintColor = AppColors.accentColor
        pageIndicatorTintColor = AppColors.backgroundSecondary
    }
}

import UIKit

final class PageControl: UIPageControl {

    init(numberOfPages: Int) {
        super.init(frame: .zero)
        self.numberOfPages = numberOfPages
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPageControl() {
        currentPage = 0
        currentPageIndicatorTintColor = AppColors.accentColor
        pageIndicatorTintColor = AppColors.backgroundSecondary
    }
}

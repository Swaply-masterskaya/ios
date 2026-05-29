import UIKit

class BaseCoordinatingController: UIViewController & Coordinating {

    // MARK: - Internal Properties
    weak var coordinator: Coordinator?

    // MARK: - Initializers
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

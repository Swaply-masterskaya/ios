import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var viewController: BaseCoordinatingController? { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
    func finish()
    func push()
    func pop()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

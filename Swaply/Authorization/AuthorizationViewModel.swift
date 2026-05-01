import Foundation

protocol AuthorizationViewModelProtocol {
    func entryButtonTapped()
    func registerButtonTapped()
}

final class AuthorizationViewModel: AuthorizationViewModelProtocol {

    // MARK: - Constants
    private let coordinator: AuthorizationCoordinatorProtocol

    // MARK: - Initializers
    init(coordinator: AuthorizationCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Internal Methods
    func entryButtonTapped() {
        /// Пока что сделано через UserDefaults, в дальнейшем нужно переделать под отдельный сервис авторизации
        UserDefaults.standard.set(true, forKey: "isAuthorized")
        coordinator.finishFlow()
        print("entryButtonTapped")
    }

    func registerButtonTapped() {
        /// Пока что сделано через UserDefaults, в дальнейшем нужно переделать под отдельный сервис авторизации
        UserDefaults.standard.set(true, forKey: "isAuthorized")
        coordinator.finishFlow()
        print("registerButtonTapped")
    }
}

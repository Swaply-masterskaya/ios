import Foundation

protocol AuthorizationViewModelProtocol {
    func entryButtonTapped()
    func registerButtonTapped()
}

final class AuthorizationViewModel: AuthorizationViewModelProtocol {
    func entryButtonTapped() {
        print("entryButtonTapped")
    }
    func registerButtonTapped() {
        print("registerButtonTapped")
    }
}

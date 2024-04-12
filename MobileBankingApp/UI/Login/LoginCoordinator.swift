//
//  LoginCoordinator.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 08.04.2024..
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    var childCoordinator: Coordinator?
    
    func start() -> UIViewController {
        return showLogin()
    }
    
}

extension LoginCoordinator {
    
    private func showLogin() -> UIViewController {
        let vm = LoginViewModel()
        let vc = LoginViewController()
        vc.viewModel = vm
        
        vm.onGoToPinModal = { [weak self ] in
            self?.showPinModal()
        }
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
    
    func showPinModal() {
        let vm = PinModalViewModel(userAccountsService: ServiceFactory.userAccountsService)
        let vc = PinModalViewController()
        vc.viewModel = vm
        vc.modalPresentationStyle = .overFullScreen
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        
        vm.onGoToAccountScreen = { [weak self] in
            self?.navigationController.dismiss(animated: false)
            self?.goToAccountScreen()
        }
        
        navigationController.present(vc, animated: true)
    }
    
    func goToAccountScreen() {
        
        childCoordinator = AccountCoordinator(parentCoordinator: self, navigationController: self.navigationController)
        _ = childCoordinator?.start()
    }
}

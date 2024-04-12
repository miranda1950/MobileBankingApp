//
//  AccountCoordinator.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit


final class AccountCoordinator: Coordinator {
    private let parentCoordinator: Coordinator
    private let navigationController: UINavigationController
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return showAccount()
    }
    
}

extension AccountCoordinator {
    
    private func showAccount() -> UIViewController {
        let vm = AccountViewModel(userAccountsService: ServiceFactory.userAccountsService)
        let vc = AccountViewController()
        vc.viewModel = vm
        
        vm.onGoToTransactions = { [weak self] iban, transactions in
            self?.goToTransactions(iban: iban, transactions: transactions)
        }
        
        vm.showHamburgerModal = { [weak self] in
            self?.showHamburgerView()
        }
        navigationController.viewControllers = [vc]
        return navigationController
    }
    
    private func goToTransactions(iban: String, transactions: [Transaction]) {
        let vm = TransactionsViewModel(iban: iban, transactions: transactions)
        let vc = TransactionsViewController()
        vc.viewModel = vm
        
        vm.onDismissed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    private func showHamburgerView() {
        let vc = HamburgerViewController()
        
        vc.onLogout = { [weak self] in
            self?.navigationController.dismiss(animated: false)
            _ = self?.parentCoordinator.start()
        }
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: false)
    }
}

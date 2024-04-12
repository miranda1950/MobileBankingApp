//
//  RootCoordinator.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 08.04.2024..
//

import UIKit

final class RootCoordinator: Coordinator {
    
    
    let navigationController = UINavigationController()
    var childCoordinator: Coordinator?
    
    
    func start() -> UIViewController {
        return showLogin()
    }
}

extension RootCoordinator {
    
    private func showLogin() -> UIViewController {
        let loginCoordinator = LoginCoordinator()
        childCoordinator = loginCoordinator
        let vc = loginCoordinator.start()
        return vc
        
    }
}

//
//  PinModalViewModel.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 11.04.2024..
//

import UIKit


final class PinModalViewModel {
    
    var onDismissed: EmptyCallback?
    var onGoToAccountScreen: EmptyCallback?
    var isShown = false
    var isPinWrong = false
    
    private var userAccountsService: UserAccountsServiceProtocol
    
    init(userAccountsService: UserAccountsServiceProtocol) {
        self.userAccountsService = userAccountsService
    }
    
    var currentPin: Int {
        return userAccountsService.userTestPin ?? 0
    }
}

//
//  AccountViewModel.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit

final class AccountViewModel {
    
    private var userAccountsService: UserAccountsServiceProtocol
    
    var accounts : [Acount] = []
    var onGoToTransactions:((String, [Transaction]) -> Void)?
    var showHamburgerModal: EmptyCallback?
    var dateFormatter = DateFormatter()
    
    init(userAccountsService: UserAccountsServiceProtocol) {
        self.userAccountsService = userAccountsService
    }
    
    
    func loadAccounts() {
        
        self.userAccountsService.fetchAccounts { [weak self] result in
            
            switch (result) {
            case .success(let response):
                self?.accounts = response.acounts
            case .failure(let error):
                print("error: \( error.localizedDescription)")
            }
        }
    }
    
    func sortTransactions(_ transactions: [Transaction]) -> [Transaction] {
        
        dateFormatter.dateFormat = "dd.MM.yyyy."
        
        return transactions.sorted(by: { dateFormatter.date(from:$0.date)!.compare((dateFormatter.date(from:$1.date)!)) == .orderedDescending })
    }
}

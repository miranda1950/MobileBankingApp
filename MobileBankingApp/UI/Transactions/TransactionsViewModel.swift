//
//  TransactionsViewModel.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 10.04.2024..
//

import UIKit

final class TransactionsViewModel {
    
    var iban: String
    var transactions: [Transaction]
    
    var onDismissed: EmptyCallback?
    
    init(iban: String, transactions: [Transaction]) {
        self.iban = iban
        self.transactions = transactions
    }
    
    
}


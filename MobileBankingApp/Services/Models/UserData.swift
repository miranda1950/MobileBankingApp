//
//  UserData.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit

struct UserData: Codable {
    let user_id: String
    let acounts: [Acount]
}


struct Acount: Codable {
    let id: String
    let IBAN: String
    let amount: String
    let currency: String
    let transactions: [Transaction]
    
}

struct Transaction: Codable {
    let id: String
    let date: String
    let description: String
    let amount: String
    let type: String? 
    
    
    var dateFormat : Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let newDate = dateFormatter.date(from: date)
        return newDate
    }
    
    
}


extension Acount {
    
    var amountWithCurrency: String {
        return amount + " " + currency
    }
}

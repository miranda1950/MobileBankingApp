//
//  UserAccountsService.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 11.04.2024..
//

import UIKit


protocol UserAccountsServiceProtocol: AnyObject {
    
    var userTestPin: Int? { get  }
    
    func fetchAccounts(completionHandler: @escaping (Result<UserData, Error>) -> Void)
    
}


final class UserAccountsService: UserAccountsServiceProtocol {
    
    private let fileService: FileServiceProtocol
    
    init(_ fileService: FileServiceProtocol) {
        self.fileService = fileService
    }
    
    var userTestPin: Int? {
        get {
            return 1234
        }
    }
    
    func fetchAccounts(completionHandler: @escaping (Result<UserData, Error>) -> Void) {
        
        fileService.decodeJson(completionHandler: completionHandler)
    }
    
}

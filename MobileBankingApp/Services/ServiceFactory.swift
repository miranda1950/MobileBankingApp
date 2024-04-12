//
//  ServiceFactory.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 12.04.2024..
//

import UIKit

class ServiceFactory {
    
    static var fileService: FileServiceProtocol {
        
        let fileService = FileService()
        return fileService
    }
    
    
    static var userAccountsService: UserAccountsServiceProtocol {
        return UserAccountsService(fileService)
    }
    
    
}

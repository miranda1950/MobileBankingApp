//
//  LoginViewModel.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 08.04.2024..
//

import UIKit


final class LoginViewModel {
    
    var onGoToPinModal: EmptyCallback?
    var onGoToAccountScreen: EmptyCallback?
    
    
    var title: String {
        return "Smart Finances"
    }
    
    var name: String {
        return "Name"
    }
    
    var login: String {
        return "LOGIN"
    }
}

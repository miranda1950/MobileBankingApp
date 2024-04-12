//
//  Coordinator.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 08.04.2024..
//

import UIKit


public protocol Coordinator: AnyObject {
    @discardableResult func start() -> UIViewController
}

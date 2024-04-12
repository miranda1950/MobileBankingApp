//
//  AccountCardView.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit
import SnapKit


final class AccountCardView: UIView {
    
    var account: Acount?
    
    
    init(account: Acount ) {
        self.account = account
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .yellowRBA
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.yellowRBABorder.cgColor
        addSubview(container)
        return container
    }()
    
    private lazy var bankNameLabel: UILabel = {
        let label = UILabel()
        label.text = "RBA"
        label.style(.body1Bold, color: .white, alignment: .left)
        label.numberOfLines = 1
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var ibanLabel: UILabel = {
        let label = UILabel()
        label.text = account?.IBAN
        label.style(.body2Medium, color: .white, alignment: .left)
        label.numberOfLines = 1
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var bankLogoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage.rbaLogo
        containerView.addSubview(logoImage)
        return logoImage
    }()
    
    private lazy var availabelFundsLabel: UILabel = {
        let label = UILabel()
        label.text = "Raspoloživ iznos"
        label.style(.body3Bold, color: .white, alignment: .left)
        label.numberOfLines = 1
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var availabelAmountLabel: UILabel = {
        let label = UILabel()
        label.text = account?.amountWithCurrency
        label.style(.body2Bold, color: .white, alignment: .left)
        label.numberOfLines = 1
        containerView.addSubview(label)
        return label
    }()
    
}

extension AccountCardView {
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        bankNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(12)
            make.left.equalTo(containerView.snp.left).offset(20)
            make.height.equalTo(40)
        }
        
        ibanLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(52)
            make.left.equalTo(containerView.snp.left).offset(20)
            make.right.equalTo(containerView.snp.right).offset(-15)
        }
        
        bankLogoImage.snp.makeConstraints { (make) ->Void in
            make.top.equalTo(containerView.snp.top).offset(12)
            make.right.equalTo(containerView.snp.right).offset(-15)
        }
        
        availabelFundsLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(ibanLabel.snp.bottom).offset(33)
            make.left.equalTo(containerView.snp.left).offset(20)
            make.height.equalTo(18)
        }
        
        availabelAmountLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(availabelFundsLabel.snp.bottom).offset(8)
            make.left.equalTo(containerView.snp.left).offset(20)
            make.height.equalTo(19)
            
        }     
    }
}

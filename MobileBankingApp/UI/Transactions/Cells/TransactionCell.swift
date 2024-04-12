//
//  TransactionCell.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 10.04.2024..
//

import UIKit

final class TransactionCell: UITableViewCell {
    
    
    var transaction: Transaction? {
        didSet {
            transactionNameLabel.text = transaction?.description
            dateLabel.text = transaction?.date
            amountLabel.text = transaction?.amount
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
    }
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .darkGray2
        container.layer.cornerRadius = 16
        addSubview(container)
        return container
    }()
    
    private lazy var transactionNameLabel: UILabel = {
        let label = UILabel()
        label.style(.body2Bold, color: .white, alignment: .left)
        label.numberOfLines = 3
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.style(.body3Medium, color: .grayText2, alignment: .left)
        label.numberOfLines = 1
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.style(.body2Medium, color: .white, alignment: .right)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        containerView.addSubview(label)
        return label
    }()
    
}

extension TransactionCell {
    
    private func setupConstraints() {
        
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(9)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-9)
        }
        
        transactionNameLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.left.equalTo(containerView.snp.left).offset(16)
            make.right.equalTo(amountLabel.snp.left).offset(-32)
            
        }
        
        dateLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(transactionNameLabel.snp.bottom).offset(8)
            make.left.equalTo(containerView.snp.left).offset(16)
            make.bottom.equalTo(containerView.snp.bottom).offset(-16)
            
        }
        
        amountLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.right.equalTo(containerView.snp.right).offset(-16)
            make.left.equalTo(transactionNameLabel.snp.right).offset(32)
            
        }
    }
}

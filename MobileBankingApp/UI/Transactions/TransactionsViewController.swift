//
//  TransactionsViewController.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 10.04.2024..
//

import UIKit


final class TransactionsViewController: UIViewController {
    
    var viewModel: TransactionsViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    deinit {
        print("deinit")
    }
    
    private lazy var backIcon: UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage.backIcon
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBackToAccounts)))
        view.addSubview(backImage)
        return backImage
    }()
    
    
    private lazy var bankLogoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage.rbaLogo
        view.addSubview(logoImage)
        return logoImage
    }()
    
    private lazy var bankNameLabel: UILabel = {
        let label = UILabel()
        label.text = "RBA"
        label.style(.headline3, color: .white, alignment: .left)
        label.numberOfLines = 1
        view.addSubview(label)
        return label
    }()
    
    private lazy var ibanLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.iban
        label.style(.headline3, color: .white, alignment: .left)
        label.numberOfLines = 1
        view.addSubview(label)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "transactionCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        return tableView
    }()
}

extension TransactionsViewController {
    
    private func setupView() {
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupConstraints() {
        
        backIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        bankLogoImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            
        }
        
        bankNameLabel.snp.makeConstraints { (make) ->Void in
            make.top.equalTo(backIcon.snp.bottom).offset(10)
            make.left.equalTo(backIcon.snp.left).offset(0)
        }
        
        ibanLabel.snp.makeConstraints { (make) ->Void in
            make.top.equalTo(bankNameLabel.snp.bottom).offset(2)
            make.left.equalTo(bankNameLabel.snp.left).offset(0)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        tableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(ibanLabel.snp.bottom).offset(44)
            make.left.equalTo(bankNameLabel.snp.left).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
    }
    
    @objc private func goBackToAccounts(_ sender: UITapGestureRecognizer) {
        
        viewModel.onDismissed?()
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        
        let transaction = viewModel.transactions[indexPath.row]
        cell.transaction = transaction
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
}

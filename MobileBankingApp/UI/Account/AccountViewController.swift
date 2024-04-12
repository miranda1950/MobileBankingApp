//
//  AccountViewController.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit
import SnapKit

final class AccountViewController: UIViewController {
    
    var viewModel: AccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadAccounts()
        createAccountCardViews()
        setupConstraints()
    }
    
    
    deinit {
        
        print("deinitaccount")
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Bankovni računi"
        titleLabel.numberOfLines = 2
        titleLabel.style(.headline1, alignment: .left)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        return titleLabel
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.settingsIcon, for: .normal)
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        view.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = viewModel.accounts.count
        pageControl.backgroundStyle = .minimal
        pageControl.backgroundColor = .yellowRBA
        pageControl.hidesForSinglePage = true
        pageControl.layer.cornerRadius = 12
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.yellowRBA
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
        return pageControl
    }()
    
    
}

extension AccountViewController {
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(68)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-80)
        }
        
        settingsButton.snp.makeConstraints { (make ) -> Void in
            make.top.equalTo(view.snp.top).offset(68)
            make.right.equalTo(view.snp.right).offset(20)
            
        }
        scrollView.snp.makeConstraints { (make) -> Void in
            
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.height.equalTo(25)
        }
        
        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * viewModel.accounts.count , height: 200)
    }
    
    private func createAccountCardViews() {
        for (index, account) in viewModel.accounts.enumerated() {
            lazy var accountCardView: AccountCardView = {
                let accountCardView = AccountCardView(account: account)
                accountCardView.layer.cornerRadius = 16
                accountCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToTransactions)))
                scrollView.addSubview(accountCardView)
                return accountCardView
            }()
            
            let screenWidth = UIScreen.main.bounds.width
            accountCardView.frame = CGRect(x: screenWidth * CGFloat(index), y: 0, width: screenWidth, height: 200)
            
        }
    }
    
    @objc private func goToTransactions(_ sender: UITapGestureRecognizer){
        guard let accountCardView = sender.view as? AccountCardView else { return }
        guard let iban = accountCardView.account?.IBAN else { return }
        guard let transactions = accountCardView.account?.transactions else { return }
        let sortedTransactions = viewModel.sortTransactions(transactions)
        
        viewModel.onGoToTransactions?(iban, sortedTransactions)
        
    }
    
    @objc private func settingsTapped() {
        viewModel.showHamburgerModal?()
    }
}

extension AccountViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        
    }
}

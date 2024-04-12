//
//  LoginViewController.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 08.04.2024..
//

import UIKit
import SnapKit




final class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.title
        titleLabel.style(.headline2, alignment: .center)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        return titleLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = viewModel.name
        nameLabel.style(.headline4, alignment: .center)
        nameLabel.textColor = .white
        view.addSubview(nameLabel)
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.contentVerticalAlignment = .center
        field.textColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Please enter your name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkStroke])
        field.backgroundColor = .darkInput
        field.autocapitalizationType = UITextAutocapitalizationType.none
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.darkStroke.cgColor
        field.setLeftPaddingPoints(20)
        field.setRightPaddingPoints(20)
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        view.addSubview(field)
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkButton
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.layer.cornerRadius = 16
        let title = NSMutableAttributedString(string: viewModel.login)
        title.style(.body2Medium, color: .white)
        button.isEnabled = false
        button.alpha = 0.5
        button.setAttributedTitle(title, for: .normal)
        view.addSubview(button)
        return button
    }()
    
}

extension LoginViewController {
    
    private func setupView() {
        view.backgroundColor = .black
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(75)
            make.left.equalTo(view.snp.left).offset(20)
            
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(78)
            make.leading.equalTo(titleLabel.snp.leading).offset(0)
            
        }
        
        nameTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottomMargin).offset(22)
            make.leading.equalTo(nameLabel.snp.leading).offset(0)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom).offset(-92)
            make.leading.equalTo(nameTextField.snp.leading).offset(0)
            make.trailing.equalTo(nameTextField.snp.trailing).offset(0)
            make.height.equalTo(52)
            
        }
        
    }
    
    @objc private func loginTapped() {
        nameTextField.resignFirstResponder()
        viewModel.onGoToPinModal?()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        var translation: CGFloat = 0
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if nameTextField.isEditing {
                translation = CGFloat(-keyboardSize.height)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.2) {
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc private func editingChanged() {
        
        if nameTextField.text?.isEmpty == true || nameTextField.text == "" {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        } else {
            loginButton.isEnabled = true
            loginButton.alpha = 1
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        handleStartEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleEndEditing()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    
    private func handleStartEditing() {
        nameTextField.layer.borderColor = UIColor.greyStroke.cgColor
    }
    
    private func handleEndEditing() {
        nameTextField.layer.borderColor = UIColor.darkStroke.cgColor
    }
}

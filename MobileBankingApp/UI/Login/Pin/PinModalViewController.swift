//
//  PinModalViewController.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 09.04.2024..
//

import UIKit
import SnapKit

final class PinModalViewController:UIViewController {
    
    var viewModel: PinModalViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    
    private lazy var backgroundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .black
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.alpha = 0.6
        view.addSubview(backView)
        return backView
    }()
    
    private lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .darkButton
        container.layer.cornerRadius = 24
        view.addSubview(container)
        return container
    }()
    
    private lazy var identityKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "Identifikacijski ključ"
        label.numberOfLines = 1
        label.style(.headline4, color: .white)
        view.addSubview(label)
        return label
    }()
    
    private lazy var pinTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.contentVerticalAlignment = .center
        field.textColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Please enter PIN", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkStroke])
        field.backgroundColor = .darkInput
        field.autocapitalizationType = UITextAutocapitalizationType.none
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor =  UIColor.darkStroke.cgColor
        field.isSecureTextEntry = true
        field.keyboardType = .numberPad
        field.setLeftPaddingPoints(20)
        field.setRightPaddingPoints(24)
        let newView = UIView()
        newView.frame = CGRect(x: 0, y: 0, width: 38, height: 24)
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "eye.slash")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPasswordTapped)))
        newView.addSubview(imageView)
        field.rightView = newView
        field.rightViewMode = .always
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        view.addSubview(field)
        return field
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(checkPin), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var wrongEntryLabel: UILabel = {
        let label = UILabel()
        label.text = "Pogrešan unos!"
        label.numberOfLines = 1
        label.isHidden = true
        label.style(.body3Medium, color: .error)
        view.addSubview(label)
        return label
    }()
}


extension PinModalViewController {
    
    private func setConstraints() {
        
        container.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        backgroundView.snp.makeConstraints { ( make) -> Void in
            make.top.equalTo(view.snp.top).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
        }
        
        identityKeyLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(container.snp.top).offset(20)
            make.leading.equalTo(container.snp.leading).offset(20)
            make.right.equalTo(container.snp.right).offset(20)
        }
        
        pinTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(identityKeyLabel.snp.bottom).offset(22)
            make.leading.equalTo(container.snp.leading).offset(20)
            make.right.equalTo(container.snp.right).offset(-20)
            make.height.equalTo(52)
        }
        
        wrongEntryLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(pinTextField.snp.bottom).offset(12)
            make.leading.equalTo(container.snp.leading).offset(20)
        }
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(container.snp.bottom).offset(-20)
            make.leading.equalTo(container.snp.leading).offset(20)
            make.right.equalTo(container.snp.centerX).offset(-8)
        }
        print("aabb\(viewModel.currentPin)")
        confirmButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(container.snp.bottom).offset(-20)
            make.right.equalTo(container.snp.right).offset(-20)
            make.left.equalTo(container.snp.centerX).offset(8)
        }
    }
    
    @objc private func dismissModal() {
        
        viewModel.onDismissed?()
    }
    
    @objc private func checkPin() {
        if validatePin() {
            viewModel.onGoToAccountScreen?()
        } else {
            wrongEntryLabel.isHidden = false
            pinTextField.layer.borderColor = UIColor.error.cgColor
        }
    }
    
    
    @objc private func editingChanged() {
        
        if pinTextField.text?.isEmpty == true || pinTextField.text == "" {
            confirmButton.isEnabled = false
            confirmButton.alpha = 0.5
        } else {
            confirmButton.isEnabled = true
            confirmButton.alpha = 1
        }
    }
    
    @objc private func showPasswordTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        viewModel.isShown.toggle()
        pinTextField.isSecureTextEntry = !viewModel.isShown
        
        imageView.image = viewModel.isShown ? UIImage(systemName: "eye")?.withTintColor(.white, renderingMode: .alwaysOriginal) : UIImage(systemName: "eye.slash")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    
    private func validatePin() -> Bool {
        if pinTextField.text == String(viewModel.currentPin) {
            return true
        } else {
            return false
        }
    }
}

extension PinModalViewController: UITextFieldDelegate {
    
    
}

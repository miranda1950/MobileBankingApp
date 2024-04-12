//
//  HamburgerView.swift
//  Painter
//
//  Created by COBE on 27.04.2023..
//

import Foundation
import UIKit
import SnapKit


final class HamburgerViewController: UIViewController {
    
    var onLogout: EmptyCallback?
    
    let defaultWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    let dismissibleWidth: CGFloat = UIScreen.main.bounds.width * 0.25
    let maximumContainerWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    var currentContainerWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    
    var containerViewWidthConstraint: NSLayoutConstraint?
    var containerViewTrailingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    deinit {
        
        print("deinitHambModal")
    }
    
    private lazy var backgroundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .black
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateDismissView)))
        backView.alpha = 0.6
        view.addSubview(backView)
        return backView
    }()
    
 
    
    private lazy var container: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .darkGray2
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        return containerView
    }()
    
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: sizeConfig)?.withTintColor(.white,renderingMode: .alwaysOriginal)
        
        logoutButton.setImage(image ,for: .normal)
        
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        container.addSubview(logoutButton)
        return logoutButton
    }()
    
    
    private lazy var logoutLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Logout"
        nameLabel.style(.body2Medium, alignment: .center)
        nameLabel.textColor = .white
        view.addSubview(nameLabel)
        return nameLabel
    }()
    
}

extension HamburgerViewController {
    
    func setConstraints() {
        
        
        backgroundView.snp.makeConstraints { ( make) -> Void in
            make.top.equalTo(view.snp.top).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
        }

        
        container.snp.makeConstraints { ( make )-> Void in
            make.top.equalTo(view.snp.top).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            
        }
        
        logoutButton.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo(container.snp.bottom).offset(-80)
            make.left.equalTo(container.snp.left).offset(20)
            
        }
        
        logoutLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(logoutButton.snp.centerY)
            make.left.equalTo(logoutButton.snp.right).offset(12)
        }
        
        containerViewWidthConstraint = container.widthAnchor.constraint(equalToConstant: defaultWidth)
        containerViewTrailingConstraint = container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: defaultWidth)
        
        containerViewWidthConstraint?.isActive = true
        containerViewTrailingConstraint?.isActive = true
    }
    
    @objc private func logoutTapped() {
        onLogout?()
    }
    
    func setupPanGesture() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanAction(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: container)

        let isDraggingRight = translation.x > 0
        
        let newWidth = currentContainerWidth - translation.x
        
        switch gesture.state {
        case .changed:
            if newWidth < maximumContainerWidth {
                
                containerViewWidthConstraint?.constant = newWidth
                
                view.layoutIfNeeded()
            }
            
        case .ended:
            
            if newWidth < dismissibleWidth {
                self.animateDismissView()
            }
            
            else if newWidth < defaultWidth {
                
                animateContainerWidth(defaultWidth)
            }

            else if newWidth > defaultWidth && !isDraggingRight {
                
                animateContainerWidth(maximumContainerWidth)
            }
        default:
            break
        }
    }
    
    func animateContainerWidth(_ width: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewWidthConstraint?.constant = width
            self.view.layoutIfNeeded()
        }
        currentContainerWidth = width
    }
    
    func animateShowDimmedView() {
        backgroundView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 0.6
        }
    }
    
    func animatePresentContainer() {
       
        UIView.animate(withDuration: AnimationsConstants.durationConstans) { [self] in
            containerViewTrailingConstraint?.constant = 0
            view.layoutIfNeeded()
        }
    }
    
    @objc func animateDismissView() {
        UIView.animate(withDuration: AnimationsConstants.durationConstans) { [self] in
            containerViewTrailingConstraint?.constant = defaultWidth
            view.layoutIfNeeded()
        }
        backgroundView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

enum AnimationsConstants {
    static let durationConstans = 0.3
}

//
//  OnboardingCollectionViewCell.swift
//  HomeWork
//
//  Created by rendi on 17.04.2024.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }()
    
    let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    
    var actionButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stepNumberLabel)
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height * 0.25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stepNumberLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            stepNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stepNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            actionButton.topAnchor.constraint(equalTo: stepNumberLabel.bottomAnchor, constant: 50),
            actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionButtonPressed() {
        actionButtonHandler?()
    }
}


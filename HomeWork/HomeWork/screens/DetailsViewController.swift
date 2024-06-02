//
//  DetailsViewController.swift
//  HomeWork
//
//  Created by rendi on 17.04.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    var number: Int?

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        if let number = number {
            numberLabel.text = "Title: \(number)"
        }
    }
}

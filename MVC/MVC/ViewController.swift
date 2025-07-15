//
//  ViewController.swift
//  MVC
//
//  Created by Sirarpi Bayramyan on 15.07.25.
//

import UIKit

/// View + Controller
class ViewController: UIViewController {

    // MARK: - UI Elements
    private let nameLabel = UILabel()
    private let ageLabel = UILabel()
    private let loadButton = UIButton(type: .system)

    // MARK: - Model
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup View (View)
    private func setupUI() {
        view.backgroundColor = .red

        nameLabel.text = "Name: "
        ageLabel.text = "Age: "
        loadButton.setTitle("Load User", for: .normal)

        [nameLabel, ageLabel, loadButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loadButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 40),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        loadButton.addTarget(self, action: #selector(loadUserData), for: .touchUpInside)
    }

    // MARK: - Controller Logic
    @objc private func loadUserData() {
        // Simulate loading data
        user = User(name: "Alice", age: 28)
        updateView()
    }

    private func updateView() {
        guard let user = user else { return }
        nameLabel.text = "Name: \(user.name)"
        ageLabel.text = "Age: \(user.age)"
    }
}

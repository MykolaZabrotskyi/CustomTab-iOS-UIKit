//
//  ViewController.swift
//  CustomTab
//
//  Created by Mykola Zabrotskyi on 02.03.2026.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let firstTabView: CustomTabView = {
        let tabView = CustomTabView(
            frame: .zero,
            tabTitles: Constant.longArrayWithTabTitles
        )
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        return tabView
    }()
    
    private let secondTabView: CustomTabView = {
        let tabView = CustomTabView(
            frame: .zero,
            tabTitles: Constant.shortArrayWithTabTitles
        )
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        return tabView
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        
        divider.backgroundColor = .separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
        
        firstTabView.delegate = self
        secondTabView.delegate = self
    }
}

// MARK: - Private Methods

private extension ViewController {
    func setupLayout() {
        view.addSubview(secondTabView)
        view.addSubview(firstTabView)
        view.addSubview(divider)
        
        NSLayoutConstraint.activate([
            firstTabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            firstTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstTabView.heightAnchor.constraint(equalToConstant: 50),
            
            divider.topAnchor.constraint(equalTo: firstTabView.bottomAnchor, constant: 25),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 3),
            
            secondTabView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 22),
            secondTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondTabView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - CustomTabViewDelegate

extension ViewController: CustomTabViewDelegate {
    func customTabView(_ view: CustomTabView, didSelectTabAt index: Int) {
        print("Selected index: " + String(index))
    }
}

// MARK: - Constatns

private extension ViewController {
    enum Constant {
        static let longArrayWithTabTitles = [
            "Home",
            "Messages",
            "Profile",
            "Settings",
            "Notifications",
            "Privacy",
            "Help"
        ]
        static let shortArrayWithTabTitles = ["Home", "Search", "Profile"]
    }
}

#Preview {
    ViewController()
}

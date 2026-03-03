//
//  ViewController.swift
//  CustomTab
//
//  Created by Mykola Zabrotskyi on 02.03.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let customTabView: CustomTabView = {
        let tabView = CustomTabView(
            tabTitles: Constant.CustomTabView.tabTitles,
            mainColor: Constant.CustomTabView.Color.main,
            secondColor: Constant.CustomTabView.Color.second
        )
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        return tabView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
}

// MARK: - Private Methods

private extension ViewController {
    func setupLayout() {
        view.addSubview(customTabView)
        
        customTabView.delegate = self
        
        NSLayoutConstraint.activate([
            customTabView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constant.Layout.Padding.top
            ),
            customTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabView.heightAnchor.constraint(equalToConstant: Constant.CustomTabView.height)
        ])
    }
}

// MARK: - CustomTabViewDelegate

extension ViewController: CustomTabViewDelegate {
    func customTabView(_ view: CustomTabView, didSelectTabAt index: Int) {
        debugPrint("Selected index: " + String(index))
    }
}

// MARK: - Constants

private extension ViewController {
    enum Constant {
        enum CustomTabView {
            static let height: CGFloat = 50.0
            
            static let tabTitles = [
                "Home",
                "Messages",
                "Profile",
                "Settings",
                "Notifications",
                "Privacy",
                "Help"
            ]
            
            enum Color {
                static let main = UIColor.systemYellow
                static let second = UIColor.systemBlue
            }
        }
        
        enum Layout {
            enum Padding {
                static let top: CGFloat = 50.0
            }
        }
    }
}

#Preview {
    ViewController()
}

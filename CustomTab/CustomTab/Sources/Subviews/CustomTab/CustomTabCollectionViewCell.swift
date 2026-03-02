//
//  CustomTabCollectionViewCell.swift
//  CustomTab
//
//  Created by Mykola Zabrotskyi on 02.03.2026.
//

import UIKit

class CustomTabCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Constant.Label.font
        label.textColor = Constant.Label.Color.notSelected
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            UIView.transition(with: titleLabel, duration: 0.2, options: .transitionCrossDissolve) {
                self.titleLabel.textColor = self.isSelected
                ? Constant.Label.Color.whenSelected
                : Constant.Label.Color.notSelected
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private Methods

private extension CustomTabCollectionViewCell {
    
    // MARK: - Setup
    
    func setupLayout() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Constants

private extension CustomTabCollectionViewCell {
    enum Constant {
        enum Label {
            static let font: UIFont = .systemFont(ofSize: 25, weight: .semibold)
            
            enum Color {
                static let whenSelected: UIColor = .systemIndigo
                static let notSelected: UIColor = .systemGray
            }
        }
    }
}

#Preview("Unselected State") {
    let cell = CustomTabCollectionViewCell(frame: CGRect(
        x: 0,
        y: 0,
        width: 120,
        height: 44
    ))
    
    cell.configure(with: "Home")
    
    return cell
}

#Preview("Selected State") {
    let cell = CustomTabCollectionViewCell(frame: CGRect(
        x: 0,
        y: 0,
        width: 120,
        height: 44
    ))
    
    cell.configure(with: "Home")
    
    cell.isSelected = true
    
    return cell
}

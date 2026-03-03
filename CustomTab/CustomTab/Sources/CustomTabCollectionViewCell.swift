//
//  CustomTabCollectionViewCell.swift
//  CustomTab
//
//  Created by Mykola Zabrotskyi on 02.03.2026.
//

import UIKit

final class CustomTabCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var mainColor: UIColor = .systemBlue
    private var secondColor: UIColor = .systemGray
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Constant.Label.font
        label.textColor = self.secondColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            UIView.transition(
                with: titleLabel,
                duration: Constant.Label.Transition.duration,
                options: Constant.Label.Transition.options
            ) {
                self.titleLabel.textColor = self.isSelected
                ? self.mainColor
                : self.secondColor
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
    
    func configure(with title: String, mainColor: UIColor, secondColor: UIColor) {
        titleLabel.text = title
        self.mainColor = mainColor
        self.secondColor = secondColor
        
        titleLabel.textColor = isSelected ? mainColor : secondColor
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
            static let font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            
            enum Transition {
                static let duration = 0.2
                static let options = UIView.AnimationOptions.transitionCrossDissolve
            }
        }
    }
}

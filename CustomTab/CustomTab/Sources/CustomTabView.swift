//
//  CustomTabView.swift
//  CustomTab
//
//  Created by Mykola Zabrotskyi on 02.03.2026.
//

import UIKit

protocol CustomTabViewDelegate: AnyObject {
    func customTabView(_ view: CustomTabView, didSelectTabAt index: Int)
}

final class CustomTabView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomTabViewDelegate?
    
    private var tabTitles: [String] = []
    private var mainColor: UIColor = .systemBlue
    private var secondColor: UIColor = .systemGray
    
    private var selectedIndex: Int = 0
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = tabTitles.count > Constant.ShortTable.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: CustomTabCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = mainColor
        view.layer.cornerRadius = Constant.Indicator.cornerRadius
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tabTitles: [String], mainColor: UIColor, secondColor: UIColor) {
        self.init(frame: .zero)
        
        self.tabTitles = tabTitles
        self.mainColor = mainColor
        self.secondColor = secondColor
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            self.updateIndicatorPosition(animated: false)
        }
    }
}

// MARK: - Private Methods

private extension CustomTabView {
    func updateIndicatorPosition(animated: Bool) {
        guard !tabTitles.isEmpty else {
            return
        }
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        guard let attributes = collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath) else { return
        }
        
        let text = tabTitles[selectedIndex]
        let textWidth = text.size(withAttributes: [.font: Constant.Label.font]).width
        let indicatorWidth = textWidth / Constant.Indicator.widthDivider
        
        let centeredX = attributes.frame.minX
        + (attributes.frame.width - indicatorWidth)
        / Constant.Indicator.emptySpaceDivider
        
        let targetFrame = CGRect(
            x: centeredX,
            y: bounds.height - Constant.Indicator.height,
            width: indicatorWidth,
            height: Constant.Indicator.height
        )
        
        if animated {
            UIView.animate(
                withDuration: Constant.Indicator.Animation.duration,
                delay: Constant.Indicator.Animation.delay,
                usingSpringWithDamping: Constant.Indicator.Animation.damping,
                initialSpringVelocity: Constant.Indicator.Animation.velocity,
                options: Constant.Indicator.Animation.options
            ) {
                self.indicatorView.frame = targetFrame
            }
        } else {
            indicatorView.frame = targetFrame
        }
    }
    
    // MARK: - Setup
    
    func setupLayout() {
        addSubview(collectionView)
        collectionView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        DispatchQueue.main.async {
            self.updateIndicatorPosition(animated: false)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CustomTabView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomTabCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.configure(with: tabTitles[indexPath.item], mainColor: self.mainColor, secondColor: self.secondColor)
        
        if indexPath.item == selectedIndex {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedIndex != indexPath.item else {
            return
        }
        
        selectedIndex = indexPath.item
        updateIndicatorPosition(animated: true)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        delegate?.customTabView(self, didSelectTabAt: selectedIndex)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CustomTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.bounds.height
        
        if tabTitles.count <= Constant.ShortTable.count && !tabTitles.isEmpty {
            let width = collectionView.bounds.width / CGFloat(tabTitles.count)
            return CGSize(width: width, height: height)
        } else {
            let text = tabTitles[indexPath.item]
            let textWidth = text.size(withAttributes: [.font: Constant.Label.font]).width
            let padding: CGFloat = Constant.ShortTable.padding
            
            return CGSize(width: textWidth + padding, height: height)
        }
    }
}

// MARK: - Constants

private extension CustomTabView {
    enum Constant {
        enum ShortTable{
            static let count = 3
            static let padding: CGFloat = 32.0
        }
        
        enum Label {
            static let font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        }
        
        enum Indicator {
            static let height: CGFloat = 3.0
            static let widthDivider = 2.0
            static let emptySpaceDivider = 2.0
            static let cornerRadius: CGFloat = 2.0
            
            enum Animation {
                static let duration = 0.3
                static let delay = 0.0
                static let damping = 0.8
                static let velocity = 0.5
                static let options = UIView.AnimationOptions.curveEaseInOut
            }
        }
    }
}

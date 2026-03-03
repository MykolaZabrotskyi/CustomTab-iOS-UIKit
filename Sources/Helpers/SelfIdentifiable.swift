import UIKit

protocol SelfIdentifiable { }

extension SelfIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: SelfIdentifiable { }

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(cell: Cell.Type) {
        self.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }
  
    func register<T: UICollectionReusableView>(
        view: T.Type,
        for kind: String,
        with identifier: String = T.identifier
    ) {
        self.register(
            view.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: identifier
        )
    }
    
    func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Cell \(String(describing: Cell.self)) not registered")
        }
        return cell
    }
    
    func dequeueSupplementary<View: UICollectionReusableView>(of kind: String, for indexPath: IndexPath) -> View {
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: View.identifier,
            for: indexPath
        ) as? View else {
            fatalError("View \(String(describing: View.self)) not registered")
        }
        return view
    }
}

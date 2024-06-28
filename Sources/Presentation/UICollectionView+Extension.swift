import UIKit

public extension UICollectionView {

    func registerCell(_ cellClass: AnyClass) {
        register(cellClass.self, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }

    func registerHeaderFooterView(
        _ headerFooterClass: AnyClass,
        forSupplementaryViewOfKind elementKind: String
    ) {
        register(
            headerFooterClass.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: String(describing: headerFooterClass.self)
        )
    }

    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(
                withReuseIdentifier: String(describing: T.self),
                for: indexPath
            ) as? T
        else {
            fatalError("Unable to dequeue a cell with identifier \(T.self)")
        }

        return cell
    }

    func dequeueHeaderFooterView<T: UICollectionReusableView>(
        for indexPath: IndexPath,
        ofKind elementKind: String
    ) -> T {
        guard
            let headerFooterView = dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: String(describing: T.self),
                for: indexPath
            ) as? T
        else {
            fatalError("Unable to dequeue a view with identifier \(T.self)")
        }

        return headerFooterView
    }
}

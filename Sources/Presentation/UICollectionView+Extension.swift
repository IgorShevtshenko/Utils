import UIKit

public extension UICollectionView {

    func registerCell(_ cellClass: AnyClass) {
        register(cellClass.self, forCellWithReuseIdentifier: String(describing: cellClass.self))
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
}

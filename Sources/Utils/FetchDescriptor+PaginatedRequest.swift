import SwiftData
import Foundation

public extension FetchDescriptor {
    
    static func fetchPaginatedArray(
        sortBy: [SortDescriptor<T>],
        from index: Int,
        itemsPerPage: Int = 20,
        context: ModelContext?,
        predicate: Predicate<T>? = nil
    ) -> PaginatedArray<T> where T: Hashable {
        let pageDescriptor = pageRequestDescriptor(
            sortBy: sortBy,
            from: index,
            itemsPerPage: itemsPerPage,
            predicate: predicate
        )
        let totalRecordsDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        let records = (try? context?.fetch(pageDescriptor)) ?? []
        let cursorDestination = index + records.count
        let totalRecordsNumber = (try? context?.fetchCount(totalRecordsDescriptor)) ?? 0
        return PaginatedArray(
            elements: records,
            cursor: totalRecordsNumber <= cursorDestination
            ? .end
            : .page(cursorDestination),
            totalElements: totalRecordsNumber
        )
    }
    
    private static func pageRequestDescriptor(
        sortBy: [SortDescriptor<T>],
        from index: Int,
        itemsPerPage: Int,
        predicate: Predicate<T>?
    ) -> FetchDescriptor {
        var descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        descriptor.fetchOffset = index
        descriptor.fetchLimit = itemsPerPage
        descriptor.includePendingChanges = true
        return descriptor
    }
}

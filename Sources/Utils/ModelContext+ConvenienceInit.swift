import SwiftData

public extension ModelContext? {
    
    init(container: ModelContainer?) {
        guard let container else {
            self = nil
            return
        }
        self = ModelContext(container)
    }
}

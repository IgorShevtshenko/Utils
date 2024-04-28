import SwiftUI
import Utils

public extension View {
    
    func fixedSizeSheet(
        isPresented: Binding<Bool>,
        @ViewBuilder makeContent: @escaping () -> some View
    ) -> some View {
        modifier(
            FixedSizeSheetModifier(
                item: Binding(
                    get: { isPresented.wrappedValue ? true.asIdentifiable() : nil },
                    set: { isPresented.wrappedValue = $0 != nil }
                ),
                makeContent: { _ in makeContent() }
            )
        )
    }

    func fixedSizeSheet<Item: Identifiable>(
        item: Binding<Item?>,
        @ViewBuilder makeContent: @escaping (Item) -> some View
    ) -> some View {
        modifier(
            FixedSizeSheetModifier(
                item: item,
                makeContent: makeContent
            )
        )
    }
}

private struct FixedSizeSheetModifier<
    Item: Identifiable,
    SheetContent: View
>: ViewModifier {
    
    private let makeContent: (Item) -> SheetContent

    @Binding private var item: Item?
    
    @State private var height = CGFloat.zero

    init(item: Binding<Item?>, makeContent: @escaping (Item) -> SheetContent) {
        _item = item
        self.makeContent = makeContent
    }
    
    func body(content: Content) -> some View {
        content.sheet(item: $item) { item in
            makeContent(item)
                .readSize { size in
                    height = size.height
                }
                .presentationDetents([.height(height)])
        }
    }
}

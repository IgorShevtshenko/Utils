import SwiftUI

public extension View {

    func popUp(
        isPresented: Binding<Bool>,
        @ViewBuilder makeContent: @escaping () -> some View
    ) -> some View {
        modifier(
            PopUpViewModifier(
                item: Binding(
                    get: { isPresented.wrappedValue ? true : nil },
                    set: { isPresented.wrappedValue = $0 != nil }
                ),
                makeContent: { _ in makeContent() }
            )
        )
    }

    func popUp<Item: Equatable>(
        item: Binding<Item?>,
        @ViewBuilder makeContent: @escaping (Item) -> some View
    ) -> some View {
        modifier(
            PopUpViewModifier(
                item: item,
                makeContent: makeContent
            )
        )
    }
}

private struct PopUpViewModifier<
    Item: Equatable,
    PopUp: View
>: ViewModifier {

    private let makeContent: (Item) -> PopUp

    @Binding private var item: Item?

    init(item: Binding<Item?>, makeContent: @escaping (Item) -> PopUp) {
        _item = item
        self.makeContent = makeContent
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            if let item {
                makeContent(item)
            }
        }
    }
}

import SwiftUI
import Utils

public struct SpanVGrid: Layout {
    
    private let spacing: CGSize
    private let minWidth: CGFloat
    
    public init(spacing: CGSize, minWidth: CGFloat) {
        self.spacing = spacing
        self.minWidth = minWidth
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let rows = computeRows(subviews: subviews, proposal: proposal)
        
        var totalHeight = rows.reduce(into: 0) { partialResult, cells in
            let sizes = cells.map { $0.sizeThatFits(.unspecified) }
            let maxViewHeight = sizes.map(\.height).max() ?? 0
            partialResult += maxViewHeight
        }

        totalHeight += CGFloat(rows.count - 1) * spacing.height
        return CGSize(
            width: proposal.replacingUnspecifiedDimensions().width,
            height: totalHeight
        )
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let rows = computeRows(subviews: subviews, proposal: proposal)
        
        var yPoint: CGFloat = bounds.minY
        
        rows.forEach { row in
            let sizes = row.map { $0.sizeThatFits(.unspecified) }
            let maxViewHeight = sizes.map(\.height).max() ?? 0
            layoutRow(row, in: bounds, proposal: proposal, at: yPoint)
            yPoint += maxViewHeight + spacing.height
        }
    }
    
    private func computeRows(
        subviews: Subviews,
        proposal: ProposedViewSize
    ) -> [[LayoutSubview]] {
        let views = subviews.map { $0 }
        let rawCellCount = getRawCellCountInRow(proposal: proposal)
        let cellCount = Int(floor(rawCellCount))
        
        guard cellCount > 0 else { return [[]] }
        return views.chunked(into: cellCount)
    }
    
    private func layoutRow(
        _ row: [LayoutSubview],
        in bounds: CGRect,
        proposal: ProposedViewSize,
        at yPosition: CGFloat
    ) {
        let sizes = row.map { $0.sizeThatFits(.unspecified) }
        let maxViewHeight = sizes.map(\.height).max() ?? 0

        var point = CGPoint(x: bounds.minX, y: yPosition)
        var viewsPositions: [(LayoutSubview, CGPoint, ProposedViewSize)] = []
        guard row.count > 1 else {
            let size = ProposedViewSize(sizes[safe: 0] ?? .zero)
            row[safe: 0]?.place(
                at: point,
                proposal: .init(width: proposal.width, height: size.height)
            )
            return
        }
        for index in row.indices {
            let width = getIdealCellWidth(proposal: proposal)
            let cellSize = ProposedViewSize(
                width: width,
                height: maxViewHeight
            )
            viewsPositions.append((row[index], point, cellSize))
            point.x += width + spacing.width
        }
        
        placeViews(viewPositions: viewsPositions)
    }
    
    private func placeViews(
        viewPositions: [(LayoutSubview, CGPoint, ProposedViewSize)]
    ) {
        viewPositions.forEach { view, position, viewSize in
            let position = CGPoint(
                x: position.x,
                y: position.y
            )
            view.place(at: position, proposal: viewSize)
        }
    }
    
    private func getIdealCellWidth(
        proposal: ProposedViewSize
    ) -> CGFloat {
        let rawCellCount = getRawCellCountInRow(proposal: proposal)
        let width = (proposal.width ?? 0 + spacing.width) / rawCellCount - spacing.width
        return max(minWidth, width)
    }
    
    private func getRawCellCountInRow(proposal: ProposedViewSize) -> Double {
        let containerWidth = proposal.replacingUnspecifiedDimensions().width
        return (containerWidth + spacing.width) / (minWidth + spacing.width)
    }
    
    private func getMaxSize(for subviews: Subviews) -> CGSize {
        subviews.reduce(.zero) { currentMaxSize, subview in
            let currentSize = subview.sizeThatFits(.unspecified)
            return CGSize(
                width: max(currentSize.width, currentMaxSize.width),
                height: max(currentSize.height, currentMaxSize.height)
            )
        }
    }
}

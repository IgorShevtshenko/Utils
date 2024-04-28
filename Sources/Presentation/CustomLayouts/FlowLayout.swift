import SwiftUI

public enum FlowLayoutAlignment {
    case leading
    case center
    case traling
}

public struct FlowLayout: Layout {

    private let alignment: FlowLayoutAlignment

    private let spacing: CGSize

    public init(spacing: CGSize, alignment: FlowLayoutAlignment = .center) {
        self.alignment = alignment
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        let maxViewHeight = sizes.map(\.height).max() ?? 0
        var currentRowWidth: CGFloat = 0
        var totalHeight: CGFloat = maxViewHeight
        var totalWidth: CGFloat = 0

        for size in sizes {
            if currentRowWidth + spacing.width + size.width > proposal.width ?? 0 {
                totalHeight += spacing.height + maxViewHeight
                currentRowWidth = size.width
            } else {
                currentRowWidth += spacing.width + size.width
            }
            totalWidth = max(totalWidth, currentRowWidth)
        }
        return CGSize(width: totalWidth, height: totalHeight)
    }

    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let rows = computeRows(subviews: subviews, proposal: proposal)

        var yPoint: CGFloat = bounds.minY

        rows.safeEnumerated().forEach { _, row in
            let sizes = row.map { $0.sizeThatFits(proposal) }
            let maxViewHeight = sizes.map(\.height).max() ?? 0
            layoutRow(row, in: bounds, proposal: proposal, at: yPoint)
            yPoint += maxViewHeight + spacing.height
        }
    }

    private func computeRows(
        subviews: Subviews,
        proposal: ProposedViewSize
    ) -> [[LayoutSubview]] {
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        var rows: [[LayoutSubview]] = [[]]
        subviews.safeEnumerated().forEach { index, view in
            let lastRowWidth = rows.last?
                .map { $0.sizeThatFits(proposal) }
                .map { $0.width + spacing.width }
                .reduce(0) { $0 + $1 } ?? 0
            if lastRowWidth + sizes[index].width < proposal.width ?? 0 {
                rows[rows.count - 1].append(view)
            } else {
                rows.append([view])
            }
        }
        return rows
    }

    private func layoutRow(
        _ row: [LayoutSubview],
        in bounds: CGRect,
        proposal: ProposedViewSize,
        at yPosition: CGFloat
    ) {
        let sizes = row.map { $0.sizeThatFits(proposal) }
        let rowWidth = row.map { $0.sizeThatFits(proposal) }
            .map { $0.width + spacing.width }
            .reduce(0) { $0 + $1 }

        var point = CGPoint(x: bounds.minX, y: yPosition)
        var viewsPositions: [(LayoutSubview, CGPoint, ProposedViewSize)] = []

        for index in row.indices {
            viewsPositions.append((row[index], point, ProposedViewSize(sizes[index])))
            point.x += sizes[index].width + spacing.width
        }

        let availableWidth = bounds.width - rowWidth

        alignViews(viewsPositions: viewsPositions, using: availableWidth)
    }

    private func alignViews(
        viewsPositions: [(LayoutSubview, CGPoint, ProposedViewSize)],
        using availableWidth: CGFloat
    ) {
        viewsPositions.forEach { view, position, viewSize in
            let alignedPosition = CGPoint(
                x: position.x + getAlignment(by: availableWidth),
                y: position.y
            )
            view.place(at: alignedPosition, proposal: viewSize)
        }
    }

    private func getAlignment(by availableSpace: CGFloat) -> CGFloat {
        switch alignment {
        case .leading:
            return 0
        case .center:
            return availableSpace/2
        case .traling:
            return availableSpace
        }
    }
}

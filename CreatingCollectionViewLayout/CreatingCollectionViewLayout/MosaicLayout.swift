//
//  MosaicLayout.swift
//  collectionView-basics
//
//  Copyright © 2018年 MIsono. All rights reserved.
//
//  https://developer.apple.com/videos/play/wwdc2018/225/?time=1100
//

import UIKit

final class MosaicLayout: UICollectionViewLayout {

    var contentBounds = CGRect.zero
    var chachedAttributes = [UICollectionViewLayoutAttributes]()
    var images: [UIImage] = [UIImage]()
    let cellPadding: CGFloat = 1.0

    /// This is a great place to do any customization that takes the size of the CollectionView into account.
    /// - Called for every invalidateLayout
    /// - Cache UICollectionViewLayoutAttributes
    /// - Compute collectionViewContentSize

    init(images: [UIImage]) {
        super.init()
        self.images = images
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        // Reset chache info
        chachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)

        createAttribute(collectionView: collectionView)

    }

    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }

        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return chachedAttributes[indexPath.item]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()

        // Find any cell that sits within the query rect
        guard let firstMatchIndex = binarySearchAttributes(range: 0...chachedAttributes.endIndex - 1, rect: rect) else { return attributesArray }

        // Starting from our match, loop up and down through the array
        // until we've added all attributes with frames within our query rect
        for attributes in chachedAttributes[..<firstMatchIndex].reversed() {
            guard  attributes.frame.maxY >= rect.minY else { break }

            attributesArray.append(attributes)
        }

        for attributes in chachedAttributes[firstMatchIndex...] {
            guard  attributes.frame.minY <= rect.maxY else { break }

            attributesArray.append(attributes)
        }

        return attributesArray
    }

    private func binarySearchAttributes(range: ClosedRange<Int>, rect: CGRect) -> Int? {
        return range.filter { rect.intersects(chachedAttributes[$0].frame) }.first
    }

    /// like pinterest ui sample
    /// https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest
    private func createAttribute(collectionView: UICollectionView) {
        let contentWidth = collectionView.bounds.inset(by: collectionView.safeAreaInsets).size.width
        let column = getColumn(in: contentWidth)
        let numberOfColumns = column.xOffsets.count

        var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
        for (offset, image) in images.enumerated() {
            let index = offset > 0 ? (offset % numberOfColumns) : 0
            let cellHeight = cellPadding * 2 + image.size.height
            let frame = CGRect(x: column.xOffsets[index], y: yOffsets[index], width: column.width, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let indexPath = IndexPath(item: offset, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            attributes.frame = insetFrame
            chachedAttributes.append(attributes)

            yOffsets[index] = yOffsets[index] + cellHeight

            let contentHeight = max(contentBounds.height, frame.maxY)
            contentBounds.size = CGSize(width: contentWidth, height: contentHeight)
        }
    }

}

private func getColumn(in contentWidth: CGFloat) -> (xOffsets: [CGFloat], width: CGFloat) {

    let minColumnWidth = CGFloat(150.0)
    let numberOfColumns = Int(contentWidth / minColumnWidth)

    let width = (contentWidth / CGFloat(numberOfColumns)).rounded(.down)

    var xOffset = [CGFloat]()
    for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column) * width)
    }
    return (xOffset, width)
}

//
//  HistoryController.swift
//  collectionView-basics
//
//  Copyright © 2018年 MIsono. All rights reserved.
//

import Foundation
import UIKit

private let customImages = makeCustomImages()

final class HistoryController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = MosaicLayout(images: customImages)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCol.identifier, for: indexPath) as! SquareCol
        cell.title.text = String(indexPath.row + 1)
        cell.thumbnail.image = customImages[indexPath.row]

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

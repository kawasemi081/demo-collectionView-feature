//
//  RectangleCol.swift
//  collectionView-basics
//
//  Copyright © 2018年 MIsono. All rights reserved.
//

import Foundation
import UIKit

final class RectangleCol: UICollectionViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!

    public static let identifier = String(describing: RectangleCol.self)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//
//  SquareCol.swift
//  collectionView-basics
//
//  Copyright © 2018年 MIsono. All rights reserved.
//

import Foundation
import UIKit

final class SquareCol: UICollectionViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!

    public static let identifier = String(describing: SquareCol.self)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

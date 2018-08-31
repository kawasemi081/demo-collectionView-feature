//
//  Functions.swift
//  collectionView-basics
//
//  Copyright © 2018年 MIsono. All rights reserved.
//

import Foundation
import UIKit

enum CustomRectangle {

    case square, rectangleM, rectangleL

    static func getSize(type: CustomRectangle) -> CGSize {
        switch type {
        case rectangleL:
            return CGSize(width: 150.0, height: 150.0 / 2)
        case rectangleM:
            return CGSize(width: 150.0, height: 150.0 * 2)
        default:
            return CGSize(width: 150.0, height: 150.0)
        }
    }
}

func makeCustomImages() -> [UIImage] {
    let squareImage = UIImage.customImage(with: CustomRectangle.getSize(type: .square))
    let rectangleMImage = UIImage.customImage(with: CustomRectangle.getSize(type: .rectangleM))
    let rectangleLImage = UIImage.customImage(with: CustomRectangle.getSize(type: .square))

    let images = [rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, squareImage, squareImage, squareImage, squareImage,
                  squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage,
                  rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, squareImage, squareImage, squareImage, squareImage,
                  squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage,
                  rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, squareImage, squareImage, squareImage, squareImage,
                  squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage,
                  rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage, rectangleLImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage, rectangleMImage,
                  rectangleMImage, rectangleMImage, rectangleMImage, squareImage, squareImage, squareImage, squareImage,
                  squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage, squareImage]

    return images.shuffled()
}

extension UIImage {

    static func customImage(with size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure()
            return UIImage()
        }

        let number = Float.random(in: 0...10)
        context.setFillColor(red: CGFloat(0.9), green: CGFloat(0.2), blue: CGFloat(number * 0.1), alpha: 1.0)
        context.fill(rect)

        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure()
            return UIImage()
        }
        UIGraphicsEndImageContext()

        return image
    }
}

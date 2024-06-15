//
//  GradientIcon+Configuration.swift
//  BitpandaUISDK
//

import UIKit

extension GradientIcon {
    public struct Configuration: Hashable {
        public let image: UIImage
        public let imageTintColor: UIColor

        public init(image: UIImage, imageTintColor: UIColor) {
            self.image = image
            self.imageTintColor = imageTintColor
        }
    }
}

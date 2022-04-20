//
//  Fonts.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import UIKit.UIFont

// swiftlint:disable nesting
extension UIFont {

    // MARK: Public

    public enum Heading {
        public static var header1: UIFont {
            UIFont.makeFont(size: 24, face: "Regular")
        }

        public static var header2: UIFont {
            UIFont.makeFont(size: 18, face: "Regular")
        }
    }

    public enum Body {
        public enum Size18 {
            public static var bold: UIFont {
                UIFont.makeFont(size: 18, face: "Bold")
            }

            public static var medium: UIFont {
                UIFont.makeFont(size: 18, face: "Semibold")
            }

            public static var regular: UIFont {
                UIFont.makeFont(size: 18, face: "Regular")
            }
        }

        public enum Size16 {
            public static var bold: UIFont {
                UIFont.makeFont(size: 16, face: "Bold")
            }

            public static var medium: UIFont {
                UIFont.makeFont(size: 16, face: "Semibold")
            }

            public static var regular: UIFont {
                UIFont.makeFont(size: 16, face: "Regular")
            }
        }

        public enum Size14 {
            public static var bold: UIFont {
                UIFont.makeFont(size: 14, face: "Bold")
            }

            public static var medium: UIFont {
                UIFont.makeFont(size: 14, face: "Semibold")
            }

            public static var regular: UIFont {
                UIFont.makeFont(size: 14, face: "Regular")
            }
        }

        public enum Size12 {
            public static var bold: UIFont {
                UIFont.makeFont(size: 12, face: "Bold")
            }

            public static var medium: UIFont {
                UIFont.makeFont(size: 12, face: "Semibold")
            }

            public static var regular: UIFont {
                UIFont.makeFont(size: 12, face: "Regular")
            }
        }

        public enum Size10 {
            public static var bold: UIFont {
                UIFont.makeFont(size: 10, face: "Bold")
            }

            public static var medium: UIFont {
                UIFont.makeFont(size: 10, face: "Semibold")
            }

            public static var regular: UIFont {
                UIFont.makeFont(size: 10, face: "Regular")
            }
        }
    }

    // MARK: Private

    private static func makeFont(size: CGFloat, face: String) -> UIFont {
        var descriptor = UIFontDescriptor()
        let font = UIFont.systemFont(ofSize: size)
        descriptor = descriptor.withFamily(font.familyName)
        descriptor = descriptor.withSize(CGFloat(size))
        descriptor = descriptor.withFace(face)
        return UIFont(descriptor: descriptor, size: 0)
    }
}

//
//  Fonts.swift
//  BitPandaUI
//

import UIKit.UIFont

extension UIFont {

    // MARK: Public
    
    public enum Display {
        public static var large: UIFont {
            UIFont.customFont(font: .dmSans,
                              style: .semiBold,
                              size: CustomFont.Size.Display.large.rawValue)
        }
        
        public static var medium: UIFont {
            UIFont.customFont(font: .dmSans,
                              style: .semiBold,
                              size: CustomFont.Size.Display.medium.rawValue)
        }
        
        public static var small: UIFont {
            UIFont.customFont(font: .dmSans,
                              style: .semiBold,
                              size: CustomFont.Size.Display.small.rawValue)
        }
    }

    public enum Heading {
        public static var header1: UIFont {
            UIFont.customFont(font: .dmSans,
                              style: .regular,
                              size: CustomFont.Size.Heading.h1.rawValue)
        }

        public static var header2: UIFont {
            UIFont.customFont(font: .dmSans,
                              style: .regular,
                              size: CustomFont.Size.Heading.h2.rawValue)
        }
    }

    public enum Body {
        public enum Size18 {
            public static var bold: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .bold,
                                  size: CustomFont.Size.Body.subtitle.rawValue)
            }

            public static var medium: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .semiBold,
                                  size: CustomFont.Size.Body.subtitle.rawValue)
            }

            public static var regular: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .regular,
                                  size: CustomFont.Size.Body.subtitle.rawValue)
            }
        }

        public enum Size16 {
            public static var bold: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .bold,
                                  size: CustomFont.Size.Body.large.rawValue)
            }

            public static var medium: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .semiBold,
                                  size: CustomFont.Size.Body.large.rawValue)
            }

            public static var regular: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .regular,
                                  size: CustomFont.Size.Body.large.rawValue)
            }
        }

        public enum Size14 {
            public static var bold: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .bold,
                                  size: CustomFont.Size.Body.medium.rawValue)
            }

            public static var medium: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .semiBold,
                                  size: CustomFont.Size.Body.medium.rawValue)
            }

            public static var regular: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .regular,
                                  size: CustomFont.Size.Body.medium.rawValue)
            }
        }

        public enum Size12 {
            public static var bold: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .bold,
                                  size: CustomFont.Size.Body.small.rawValue)
            }

            public static var medium: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .semiBold,
                                  size: CustomFont.Size.Body.small.rawValue)
            }

            public static var regular: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .regular,
                                  size: CustomFont.Size.Body.small.rawValue)
            }
        }

        public enum Size10 {
            public static var bold: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .bold,
                                  size: CustomFont.Size.Body.caption.rawValue)
            }

            public static var medium: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .semiBold,
                                  size: CustomFont.Size.Body.caption.rawValue)
            }

            public static var regular: UIFont {
                UIFont.customFont(font: .dmSans,
                                  style: .regular,
                                  size: CustomFont.Size.Body.caption.rawValue)
            }
        }
    }

    // MARK: Private
    
    private static func customFont(font: CustomFont,
                                   style: CustomFont.Style,
                                   size: CGFloat) -> UIFont {
        var descriptor = UIFontDescriptor()
        let fontName: String = font.rawValue + style.rawValue
        let font = UIFont(name: fontName, size: size)
        descriptor = descriptor.withFamily(font!.familyName)
        descriptor = descriptor.withSize(CGFloat(size))
        descriptor = descriptor.withFace(style.rawValue)
        return UIFont(descriptor: descriptor, size: 0)
    }
}

//
//  Fonts.swift
//  IntroGym
//
//  Created by Дывак Максим on 26.03.2025.
//

import UIKit

enum AppFonts {
    static func largeTitleThin() -> UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .thin)
    }
    
    static func largeTitleSemibold() -> UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .semibold)
    }
    
    static func title1Thin() -> UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .thin)
    }
    
    static func title1Semibold() -> UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .semibold)
    }
    
    static func title2Thin() -> UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .thin)
    }
    
    static func title2Bold() -> UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    static func title3Regular() -> UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    static func title3Bold() -> UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    static func bodyRegular() -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    static func bodyBold() -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    static func footnoteRegular() -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    static func footnoteSemibold() -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
}

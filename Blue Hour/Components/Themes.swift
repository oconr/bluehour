//
//  Themes.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI

struct Theme: Hashable {
    var displayName: String
    var name: String
    
    var tabBackground: Color
    var tabColor: Color
    var tabColorActive: Color
    var pageBackground: Color
}

var themes: [Theme] = [
    Theme(displayName: "Greyscale (Light)", name: "grey_light", tabBackground: .grey, tabColor: .darkGrey, tabColorActive: .offWhite, pageBackground: .offWhite)
]

func getTheme(_ themeName: String?) -> Theme {
    if themeName != nil {
        for theme in themes {
            if themeName! == theme.name {
                return theme
            }
        }
    }
    
    return themes[0]
}

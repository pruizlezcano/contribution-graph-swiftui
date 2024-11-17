//
//  Color+Background.swift
//  ContributionGraph
//
//  Created by Pablo Ruiz on 13/11/24.
//

import SwiftUI

public extension Color {
    #if os(macOS)
        static let background = Color(NSColor.windowBackgroundColor)
        static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
        static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
    #endif
    #if os(iOS)
        static let background = Color(UIColor.systemBackground)
        static let secondaryBackground = Color(UIColor.secondarySystemBackground)
        static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    #endif
    #if os(watchOS)
        static let background = Color.black
    #endif
}

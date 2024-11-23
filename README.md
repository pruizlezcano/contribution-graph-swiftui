# ContributionGraph

A SwiftUI library for creating GitHub-style contribution graphs for iOS, macOS, and watchOS apps.

## Features

- Customizable appearance (colors, size, spacing, corner radius)
- Support for different first day of week
- Optional legend display
- Supports iOS 13+, macOS 10.15+, watchOS 6+, and tvOS 13+
- Written in pure SwiftUI

## Installation

Add this Swift package to your Xcode project:

```swift
dependencies: [
    .package(url: "https://github.com/pruizlezcano/contribution-graph-swiftui.git", from: "1.0.0")
]
```

## Usage

```swift
import ContributionGraph
import SwiftUI

struct ContentView: View {
    let contributions = [
        Contribution(date: Date(), count: 5),
        // ... more contributions
    ]
    
    var body: some View {
        ContributionGraphView(
            contributions: contributions,
            weeks: 17,
            firstDayOfWeek: .sunday,
            targetValue: 10,
            cellColor: .green,
            cellSize: 20,
            cellSpacing: 3,
            cellCornerRadius: 4,
            showLegend: true
        )
    }
}
```

## Customization

- `weeks`: Number of weeks to display (2-17)
- `firstDayOfWeek`: Starting day of the week (.sunday or .monday)
- `targetValue`: Maximum value for contribution intensity
- `cellColor`: Color of contribution cells
- `cellSize`: Size of each cell (8-20)
- `cellSpacing`: Space between cells (0-8)
- `cellCornerRadius`: Corner radius of cells (0-8)
- `showLegend`: Toggle legend visibility

## License

MIT License
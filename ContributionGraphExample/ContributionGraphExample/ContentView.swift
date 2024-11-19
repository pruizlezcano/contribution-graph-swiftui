//
//  ContentView.swift
//  ContributionGraphExample
//
//  Created by Pablo Ruiz on 17/11/24.
//

import ContributionGraph
import SwiftUI

func sampleContributionData(weeks: Double, maxValue: Double) -> [Contribution] {
    let startDate = Date().addingTimeInterval(-Double(weeks) * 7 * 24 * 60 * 60)
    let endDate = Date()
    var contributions: [Contribution] = []
    for day in stride(from: startDate, through: endDate, by: 24 * 60 * 60) {
        let value = Int.random(in: 0 ... Int(maxValue))
        contributions.append(Contribution(date: day, count: value))
    }
    return contributions
}

struct ContentView: View {
    @State private var contributions: [Contribution] = sampleContributionData(weeks: 17, maxValue: 10)
    @State private var weeks: Double = 17
    @State private var targetValue: Double = 10
    @State private var cellColor: Color = .green
    @State private var cellSize: CGFloat = 20
    @State private var cellSpacing: CGFloat = 3
    @State private var cellCornerRadius: CGFloat = 4
    @State private var showLegend = true

    var body: some View {
        VStack {
            ContributionGraphView(contributions: contributions, weeks: Int(weeks), targetValue: targetValue, cellColor: cellColor, cellSize: cellSize, cellSpacing: cellSpacing, cellCornerRadius: cellCornerRadius, showLegend: showLegend)

            Form {
                Section {
                    HStack {
                        Slider(value: $weeks, in: 2 ... 17, step: 1)
                        Text("Weeks: \(Int(weeks))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Slider(value: $targetValue, in: 1 ... 10, step: 1)
                        Text("Target Value: \(Int(targetValue))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    ColorPicker("Block Color", selection: $cellColor)
                    HStack {
                        Slider(value: $cellSize, in: 8 ... 20, step: 1)
                        Text("Cell Size: \(Int(cellSize))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Slider(value: $cellSpacing, in: 0 ... 8, step: 1)
                        Text("Cell Spacing: \(Int(cellSpacing))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Slider(value: $cellCornerRadius, in: 0 ... 8, step: 1)
                        Text("Corner Radius: \(Int(cellCornerRadius))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Toggle("Show Legend", isOn: $showLegend)
                }
                Button("Randomize Data") {
                    contributions = sampleContributionData(weeks: weeks, maxValue: targetValue)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

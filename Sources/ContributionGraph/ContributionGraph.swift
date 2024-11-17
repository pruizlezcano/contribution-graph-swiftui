//
//  ContributionGraph.swift
//  ContributionGraph
//
//  Created by Pablo Ruiz on 13/11/24.
//

import SwiftUI

public struct ContributionGraphView: View {
    let contributions: [Contribution]
    let weeks: Int
    let firstDayOfWeek: WeekDay
    let targetValue: Double
    let cellColor: Color
    let emptyCellColor: Color
    let cellSize: CGFloat
    let cellSpacing: CGFloat
    let cellCornerRadius: CGFloat
    let showLegend: Bool

    private let calendar: Calendar

    public init(
        contributions: [Contribution],
        weeks: Int,
        firstDayOfWeek: WeekDay = .sunday,
        targetValue: Double,
        cellColor: Color = .green,
        emptyCellColor: Color = .secondaryBackground,
        cellSize: CGFloat = 20,
        cellSpacing: CGFloat = 3,
        cellCornerRadius: CGFloat = 4,
        showLegend: Bool = true
    ) {
        self.contributions = contributions
        self.weeks = weeks
        self.firstDayOfWeek = firstDayOfWeek
        self.targetValue = targetValue
        self.cellColor = cellColor
        self.emptyCellColor = emptyCellColor
        self.cellSize = cellSize
        self.cellSpacing = cellSpacing
        self.cellCornerRadius = cellCornerRadius
        self.showLegend = showLegend

        var calendar = Calendar.current
        calendar.firstWeekday = firstDayOfWeek.rawValue
        self.calendar = calendar
    }

    private var chartData: [ContributionCell] {
        let today = Date()

        // Calculate start date (beginning of the week, weeks ago)
        var dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        dateComponents.weekOfYear = (dateComponents.weekOfYear ?? 0) - weeks + 1
        let startDate = calendar.date(from: dateComponents)!

        // Create dictionary of contributions summed by date
        let contributionsDict = Dictionary(
            grouping: contributions,
            by: { calendar.startOfDay(for: $0.date) }
        ).mapValues { $0.reduce(0) { $0 + $1.count } }

        var cells: [ContributionCell] = []
        var currentDate = startDate

        // Generate cells for each day
        while currentDate <= today {
            let startOfDay = calendar.startOfDay(for: currentDate)
            cells.append(ContributionCell(
                date: startOfDay,
                value: contributionsDict[startOfDay] ?? 0,
                targetValue: targetValue,
                startOfWeek: startDate,
                firstDayOfWeek: firstDayOfWeek
            ))

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return cells
    }

    private func colorForIntensity(_ intensity: Double) -> Color {
        intensity == 0 ? emptyCellColor : cellColor.opacity(0.2 + intensity * 0.8)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: cellSpacing) {
                ForEach(0 ..< weeks, id: \.self) { week in
                    VStack(spacing: cellSpacing) {
                        ForEach(0 ..< 7) { row in
                            if let cell = chartData.first(where: { $0.column == week && $0.row == row }) {
                                Rectangle()
                                    .fill(colorForIntensity(cell.intensity))
                                    .frame(width: cellSize, height: cellSize)
                                    .clipShape(RoundedRectangle(cornerRadius: cellCornerRadius))
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
            }

            if showLegend {
                HStack(spacing: 4) {
                    Text("Less")
                        .font(.caption)

                    ForEach(0 ..< 5) { i in
                        Rectangle()
                            .fill(colorForIntensity(Double(i) / 4.0))
                            .frame(width: cellSize, height: cellSize)
                            .clipShape(RoundedRectangle(cornerRadius: cellCornerRadius))
                    }

                    Text("More")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

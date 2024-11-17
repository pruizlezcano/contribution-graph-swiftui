//
//  ContributionCell.swift
//  ContributionGraph
//
//  Created by Pablo Ruiz on 13/11/24.
//

import Foundation

struct ContributionCell: Identifiable {
    let id = UUID()
    let row: Int
    let column: Int
    let value: Int
    let date: Date
    let intensity: Double

    init(date: Date, value: Int, targetValue: Double, startOfWeek: Date, firstDayOfWeek: WeekDay) {
        let calendar = Calendar.current
        self.date = date
        self.value = value

        // Calculate row based on firstDayOfWeek
        let weekday = calendar.component(.weekday, from: date)
        let firstDayOffset = firstDayOfWeek.rawValue
        row = (weekday - firstDayOffset + 7) % 7

        // Calculate column based on weeks from start
        let weeks = calendar.dateComponents([.weekOfYear], from: startOfWeek, to: date).weekOfYear ?? 0
        column = weeks

        intensity = min(Double(value) / targetValue, 1.0)
    }
}

//
//  Contribution.swift
//  ContributionGraph
//
//  Created by Pablo Ruiz on 13/11/24.
//

import Foundation

public struct Contribution {
    let date: Date
    let count: Int

    public init(date: Date, count: Int) {
        self.date = date
        self.count = count
    }
}

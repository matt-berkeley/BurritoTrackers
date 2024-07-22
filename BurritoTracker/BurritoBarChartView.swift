//
//  BurritoBarChartView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import Charts

struct BurritoBarChartView: View {
    var wins: Double
        var losses: Double

        var body: some View {
            Chart {
                BarMark(
                    x: .value("Category", "Wins"),
                    y: .value("Count", wins)
                )
                .foregroundStyle(.green)
                .annotation(position: .top) {
                    Text(String(format: "%.0f", wins))
                        .font(.caption)
                        .foregroundColor(.green)
                }

                BarMark(
                    x: .value("Category", "Losses"),
                    y: .value("Count", losses)
                )
                .foregroundStyle(.red)
                .annotation(position: .top) {
                    Text(String(format: "%.0f", losses))
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .chartYScale(domain: [0, max(wins, losses) + 1])
            .chartYAxis {
                AxisMarks(position: .leading, values: .stride(by: 1))
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .padding()
        }
    }


//

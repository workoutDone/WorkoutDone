//
//  SkeletalMuscleMassGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import Charts

//struct SkeletalMuscleMassGraphView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct SkeletalMuscleMassGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkeletalMuscleMassGraphView()
//    }
//}

struct WeightData {
    private(set) var allWeights: [Weight]?
    
    static let weightInitial = 180
    static let weightInterval = 2
    static let weightMin = 175
    static let weightMax = 200
    
    mutating func createWeightData(days: Int) {
        // Generate sample weight date between 175 and 200 pounds (+ or - 0-3 pounds daily)
        self.allWeights = []
        var selectedWeight = WeightData.weightInitial
        var add = true
        for interval in 0...days {
            switch selectedWeight {
            case (WeightData.weightMax - WeightData.weightInterval + 1)..<Int.max:
                add = false
            case 0..<(WeightData.weightMin + WeightData.weightInterval):
                add = true
            default:
                add = (Int.random(in: 0...4) == 3) ? !add : add
            }
            
            selectedWeight = add ? selectedWeight + Int.random(in: 0...WeightData.weightInterval) : selectedWeight - Int.random(in: 0...WeightData.weightInterval)
            let selectedDate = Calendar.current.date(byAdding: .day, value: (-1 * interval), to: Date())!
            self.allWeights!.append(Weight(date: selectedDate, weight: selectedWeight))
        }
    }
}


struct Weight: Identifiable {
    let id = UUID()
    let day: Date
    let pounds: Int
    
    init(date: Date, weight: Int) {
        self.day = date
        self.pounds = weight
    }
    
    var something: String {
        "XYZ"
    }
}

class WeightViewModel: ObservableObject {
    @Published private var weightModel = WeightData()

    init() {
        weightModel.createWeightData(days: 100)
    }
    
    var allWeights: [Weight]? {
        weightModel.allWeights
    }
    
    func generateWeightData(numberOfDays: Int) {
        weightModel.createWeightData(days: numberOfDays)
    }
}


struct SkeletalMuscleMassGraphView: View {
    @ObservedObject private var weightVm = WeightViewModel()

    var body: some View {
        ZStack {
//            Color(hue: 0.58, saturation: 0.17, brightness: 1.0)
//                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                GroupBox ("Daily weight (pounds)") {
                    if let weights = weightVm.allWeights {
                        ScrollView(.horizontal) {
                            Chart {
                                ForEach(weights) { weight in
                                    LineMark(
                                        x: .value("Week Day", weight.day),
                                        y: .value("Step Count", weight.pounds)
                                    )
//                                    .annotation(position: .top) {
//                                        Text("\(weight.pounds)").font(.footnote)
//                                    }
//                                    .foregroundStyle(ViewConstants.color1)
//                                    .accessibilityLabel("\(weight.day.toString())")
//                                    .accessibilityValue("\(weight.pounds) pounds")
                                }
                            }
                            .chartYScale(domain: 0...300)
//                            .chartYScale(domain: 0...ViewConstants.maxYScale)
//                            .chartYAxis() {
//                                AxisMarks(position: .leading)
//                            }
//                            .chartXAxis {
//                                AxisMarks(preset: .extended,
//                                          position: .bottom,
//                                          values: .stride (by: .day)) { value in
//                                    if value.as(Date.self)!.isFirstOfMonth() {
//                                        AxisGridLine()
//                                            .foregroundStyle(.black.opacity(0.5))
//                                        let label = "01\n\(value.as(Date.self)!.monthName())"
//                                        AxisValueLabel(label).foregroundStyle(.black)
//                                    } else {
//                                        AxisValueLabel(
//                                            format: .dateTime.day(.twoDigits)
//                                        )
//                                    }
//                                }
//                            }
                            .frame(width: ViewConstants.dataPointWidth * CGFloat(weights.count))
                        }
                    }
                }
//                .groupBoxStyle(YellowGroupBoxStyle())
                .frame(width: ViewConstants.chartWidth,  height: 220)
            }
            .padding()
        }
    }
    
    private struct ViewConstants {
        static let color1 = Color(hue: 0.33, saturation: 0.81, brightness: 0.76)
        static let minYScale = 150
        static let maxYScale = 240
        static let chartWidth: CGFloat = 350
        static let chartHeight: CGFloat = 400
        static let dataPointWidth: CGFloat = 30
        static let barWidth: MarkDimension = 22
    }
}

struct SkeletalMuscleMassGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletalMuscleMassGraphView()
    }
}


struct YellowGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .background(Color(hue: 0.10, saturation: 0.10, brightness: 0.98))
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
    }
}


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func isFirstOfMonth() -> Bool {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day == 1
    }
    
    func monthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}

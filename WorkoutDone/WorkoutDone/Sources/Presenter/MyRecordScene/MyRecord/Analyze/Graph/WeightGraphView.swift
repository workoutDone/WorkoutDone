//
//  WeightGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/26.
//

import SwiftUI
import Charts

struct TestModel {
    let date : String
    let weight : Double
}
var list = [
    TestModel(date: "2023.01.01", weight: 0),
    TestModel(date: "2023.01.02", weight: 73),
    TestModel(date: "2023.01.03", weight: 74),
    TestModel(date: "2023.01.05", weight: 71),
    TestModel(date: "2023.01.06", weight: 60),
    TestModel(date: "2023.01.07", weight: 80),
    TestModel(date: "2023.01.07", weight: 80),
    TestModel(date: "2023.01.10", weight: 80),
    TestModel(date: "2023.01.14", weight: 80),
    TestModel(date: "2023.01.15", weight: 50),
    TestModel(date: "2023.01.29", weight: 60),
    TestModel(date: "2023.02.01", weight: 70),
    TestModel(date: "2023.02.02", weight: 75),
    TestModel(date: "2023.02.03", weight: 75),
    TestModel(date: "2023.02.05", weight: 75),
    TestModel(date: "2023.02.06", weight: 75),
    TestModel(date: "2023.02.07", weight: 75),
    TestModel(date: "2023.02.08", weight: 75),
    TestModel(date: "2023.02.09", weight: 75),
    TestModel(date: "2023.02.10", weight: 75),
    TestModel(date: "2023.02.11", weight: 0),
    
]

struct WeightGraphView: View {
    ///DateToString
    func formatDate(_ date : Date) -> String {
        let cal = Calendar.current
        let dateComponents = cal.dateComponents([.day, .month], from: date)
        guard let day = dateComponents.day,
              let month = dateComponents.month else { return "-" }
        return "\(month)/\(day)"
    }
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
        return df
    }()
    @StateObject var weightGraphViewModel = WeightGraphViewModel()
    ///TEST
    @State var testData : [TestModel] = list
    
    ///Gesture Property
    @State private var currentActiveItem : TestModel?
    ///ViewAppear 시 애니메이션 사용 위한 변수
    @State private var animate : Bool = false
    @State private var plotWidth: CGFloat = 0
    
    var body: some View {
        let max = testData.max {
            return $0.weight > $1.weight
        }
//        let max = bodyInfoGraphViewModel.bodyInfo.max { item1, item2 in
//            return item2.weight ?? 0 > item1.weight ?? 0
//        }?.weight ?? 0
        ScrollView(.horizontal) {
            Chart(testData, id: \.date) { data in
                LineMark(
                    x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())),
                    y: .value("Weight", animate ? data.weight : 0)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(Color(UIColor.color7442FF))
                PointMark(
                    x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())),
                    y: .value("Weight", animate ? data.weight : 0)
                )
                ///custom point
                .annotation(position: .overlay, alignment: .center) {
                    ZStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(UIColor.color7442FF))
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color(UIColor.colorFFFFFF))
                    }
                    .shadow(color: Color(UIColor.color7442FF), radius: 2)
                }
            }
            
//            .chartYScale(domain: <#T##ScaleDomain#>)
//            .chartYAxis() {
//                AxisMarks(position: .leading)
//            }
//            .chartXAxis {
//                AxisMarks(preset: <#T##AxisMarkPreset#>)
//            }
            .chartYAxis {
                AxisMarks(position: .trailing)
            }
            .frame(width: ViewConstants.dataPointWidth * CGFloat(testData.count))
            .padding()
        }
        .frame(height: 220)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(Color(UIColor.colorE6E0FF), lineWidth: 1)
        }
        .onAppear {
            for (index, _) in testData.enumerated() {
                withAnimation(.easeOut(duration: 0.8).delay(Double(index) * 0.05)) {
                    animate = true
                }
            }
        }
    }
    
    private struct ViewConstants {
        static let minYScale = 150
        static let maxYScale = 240
        static let dataPointWidth: CGFloat = 20
        static let chartHeight: CGFloat = 400
        static let chartWidth: CGFloat = 350
    }
}

struct WeightGraphView_Previews: PreviewProvider {
    static var previews: some View {
        WeightGraphView()
    }
}

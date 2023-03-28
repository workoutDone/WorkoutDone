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
                    y: .value("Weight", data.weight)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(Color(UIColor.color7442FF))
                PointMark(
                    x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())),
                    y: .value("Weight", data.weight)
                )
                .annotation(position: .overlay, alignment: .center) {
//                    Image(systemName: "pencil")
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
            .frame(width: ViewConstants.dataPointWidth * CGFloat(testData.count))

        }
        .frame(height: 220)
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
//struct WeightChartView3: View {
// 2    @ObservedObject private var weightVm = WeightViewModel()
// 3
// 4    var body: some View {
// 5        ZStack {
// 6            Color(hue: 0.58, saturation: 0.17, brightness: 1.0)
// 7                .edgesIgnoringSafeArea(.all)
// 8
// 9            VStack() {
//10                GroupBox ("Daily weight (pounds)") {
//11                    if let weights = weightVm.allWeights {
//12                        ScrollView(.horizontal) {
//13                            Chart {
//14                                ForEach(weights) { weight in
//15                                    LineMark(
//16                                        x: .value("Week Day", weight.day),
//17                                        y: .value("Step Count", weight.pounds)
//18                                    )
//19                                    .foregroundStyle(ViewConstants.color1)
//20                                    .accessibilityLabel("\(weight.day.toString())")
//21                                    .accessibilityValue("\(weight.pounds) pounds")
//22                                }
//23                            }
//24                            .chartYScale(domain: ViewConstants.minYScale...ViewConstants.maxYScale)
//25                            .chartYAxis() {
//26                                AxisMarks(position: .leading)
//27                            }
//28                            .chartXAxis {
//29                                AxisMarks(preset: .extended,
//30                                          position: .bottom,
//31                                          values: .stride (by: .day)) { value in
//32                                    if value.as(Date.self)!.isFirstOfMonth() {
//33                                        AxisGridLine()
//34                                            .foregroundStyle(.black.opacity(0.5))
//35                                        let label = "01\n\(value.as(Date.self)!.monthName())"
//36                                        AxisValueLabel(label).foregroundStyle(.black)
//37                                    } else {
//38                                        AxisValueLabel(
//39                                            format: .dateTime.day(.twoDigits)
//40                                        )
//41                                    }
//42                                }
//43                            }
//44                            .frame(width: ViewConstants.dataPointWidth * CGFloat(weights.count))
//45                        }
//46                    }
//47                }
//48                .groupBoxStyle(YellowGroupBoxStyle())
//49                .frame(width: ViewConstants.chartWidth,  height: ViewConstants.chartHeight)
//50
//51                Text("Generate Data")
//52                    .font(.title2)
//53                HStack {
//54                    Button("10") {
//55                        weightVm.generateWeightData(numberOfDays: 10)
//56                    }
//57                    Button("50") {
//58                        weightVm.generateWeightData(numberOfDays: 50)
//59                    }
//60                    Button("100") {
//61                        weightVm.generateWeightData(numberOfDays: 100)
//62                    }
//63                    Button("1000") {
//64                        weightVm.generateWeightData(numberOfDays: 1000)
//65                    }
//66                }
//67
//68                Spacer()
//69            }
//70            .padding()
//71        }
//    }
//
//    private struct ViewConstants {
//        static let color1 = Color(hue: 0.33, saturation: 0.81, brightness: 0.76)
//        static let minYScale = 150
//        static let maxYScale = 240
//78        static let chartWidth: CGFloat = 350
//        static let chartHeight: CGFloat = 400
//80        static let dataPointWidth: CGFloat = 20
//81    }
//}

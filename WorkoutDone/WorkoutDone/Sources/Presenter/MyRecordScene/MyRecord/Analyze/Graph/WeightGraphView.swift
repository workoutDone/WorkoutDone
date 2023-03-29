//
//  WeightGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/26.
//

import SwiftUI
import Charts

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
}

struct TestModel {
    var date : Date
    let weight : Double
}
var list = [
    TestModel(date: "2023.01.01".toDate()!, weight: 0),
    TestModel(date: "2023.01.02".toDate()!, weight: 73),
    TestModel(date: "2023.01.03".toDate()!, weight: 74),
    TestModel(date: "2023.01.05".toDate()!, weight: 71),
    TestModel(date: "2023.01.06".toDate()!, weight: 60),
    TestModel(date: "2023.01.07".toDate()!, weight: 80),
    TestModel(date: "2023.01.14".toDate()!, weight: 80),
    TestModel(date: "2023.01.15".toDate()!, weight: 50),
    TestModel(date: "2023.01.29".toDate()!, weight: 60),
    TestModel(date: "2023.02.01".toDate()!, weight: 70),
    TestModel(date: "2023.02.02".toDate()!, weight: 75),
    TestModel(date: "2023.02.03".toDate()!, weight: 75),
    TestModel(date: "2023.02.05".toDate()!, weight: 75),
    TestModel(date: "2023.02.06".toDate()!, weight: 75),
    TestModel(date: "2023.02.07".toDate()!, weight: 75),
    TestModel(date: "2023.02.08".toDate()!, weight: 75),
    TestModel(date: "2023.02.09".toDate()!, weight: 75),
    TestModel(date: "2023.02.10".toDate()!, weight: 75),
    TestModel(date: "2023.02.11".toDate()!, weight: 100),
    
]

struct WeightGraphView: View {
    ///DateToString
    func formatDate(_ date : Date) -> String {
        let cal = Calendar.current
        let dateComponents = cal.dateComponents([.day, .month, .year], from: date)
        guard let day = dateComponents.day,
              let month = dateComponents.month,
              let year = dateComponents.year else { return "-" }
        return "\(year).\(month).\(day)"
    }
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd"
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
        let max = testData.max { item1, item2 in
            return item2.weight > item1.weight
        }?.weight ?? 0
        ScrollView(.horizontal) {
            Chart(testData, id: \.date) { data in
                LineMark(
                    x: .value("Month", data.date.toString()),
                    y: .value("Weight", animate ? data.weight : 0)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(Color(UIColor.color7442FF))
                PointMark(
                    x: .value("Month", data.date.toString()),
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
                if let currentActiveItem, currentActiveItem.date == data.date {
                    RuleMark(x: .value("Month", data.date.toString()))
                        .foregroundStyle(Color(UIColor.color7442FF))
                        .lineStyle(.init(lineWidth: 1, lineCap: .round, miterLimit: 2, dash: [2], dashPhase: 5))
                        .annotation(position: .top) {
                            ZStack {
                                Image("speechBubble")
                                    .resizable()
                                    .frame(width: 50, height: 42)
                                    .offset(y: 6)
                                Text("\(Int(currentActiveItem.weight))kg")
                                    .foregroundColor(Color(UIColor.color7442FF))
                                    .font(Font(UIFont.pretendard(.semiBold, size: 14)))
                            }
                            .offset(x: 0, y: max - data.weight + 40)
                        }
                }
            }
            
//            .chartXAxis {
//                AxisMarks(preset: <#T##AxisMarkPreset#>)
//            }
            .chartYAxis {
                AxisMarks(position: .trailing)
            }
            .chartYScale(domain: 0...(max + 50))
            .chartOverlay(content: { proxy in
                GeometryReader { innerProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .onTapGesture { value in
                            if let date : String = proxy.value(atX: value.x) {
                                print(date)
                                if let currentItem = testData.first(where: { item in
                                    item.date.toString() == date
                                }) {
                                    print(currentItem.weight, "sssdd")
                                    self.currentActiveItem = currentItem
                                    self.plotWidth = proxy.plotAreaSize.width
                                }

                            }
                        }
                }
            })
            .padding()
            .frame(width: ViewConstants.dataPointWidth * CGFloat(testData.count))
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(Color(UIColor.colorE6E0FF), lineWidth: 1)
        }
        .onAppear {
            print(max, "맥스값")
            for (index, _) in testData.enumerated() {
                withAnimation(.easeOut(duration: 0.8).delay(Double(index) * 0.05)) {
                    animate = true
                }
            }
        }
        .onDisappear {
            animate = false
        }
    }
    
    private struct ViewConstants {
        static let minYScale = 150
        static let maxYScale = 240
        static let dataPointWidth: CGFloat = 60
        static let chartHeight: CGFloat = 400
        static let chartWidth: CGFloat = 350
    }
}

struct WeightGraphView_Previews: PreviewProvider {
    static var previews: some View {
        WeightGraphView()
    }
}

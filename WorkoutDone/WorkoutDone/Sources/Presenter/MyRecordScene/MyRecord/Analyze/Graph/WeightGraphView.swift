//
//  WeightGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/26.
//

//MARK: - TODO 말풍선 위치 이슈

import SwiftUI
import Charts


struct TestModel {
    var date : Date
    let weight : Double
}
var list = [
    TestModel(date: "2023.01.01".yyMMddToDate()!, weight: 1),
    TestModel(date: "2023.01.02".yyMMddToDate()!, weight: 73),
    TestModel(date: "2023.01.03".yyMMddToDate()!, weight: 74),
    TestModel(date: "2023.01.05".yyMMddToDate()!, weight: 71),
    TestModel(date: "2023.01.06".yyMMddToDate()!, weight: 60),
    TestModel(date: "2023.01.07".yyMMddToDate()!, weight: 80),
    TestModel(date: "2023.01.14".yyMMddToDate()!, weight: 80),
    TestModel(date: "2023.01.15".yyMMddToDate()!, weight: 50),
    TestModel(date: "2023.01.29".yyMMddToDate()!, weight: 60),
    TestModel(date: "2023.02.01".yyMMddToDate()!, weight: 70),
    TestModel(date: "2023.02.02".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.03".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.05".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.06".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.07".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.08".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.09".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.10".yyMMddToDate()!, weight: 75),
    TestModel(date: "2023.02.11".yyMMddToDate()!, weight: 150),

]

struct WeightGraphView: View {
    ///우측 정렬
    @Namespace var trailingID

    @StateObject var weightGraphViewModel = WeightGraphViewModel()
    ///TEST
    @State var testData : [TestModel] = list
    
    ///Gesture Property
    @State private var currentActiveItem : WorkOutDoneData?
    ///ViewAppear 시 애니메이션 사용 위한 변수
    @State private var animate : Bool = false
    @State private var plotWidth : CGFloat = 0

    var body: some View {
        ///데이터 최댓값
        let max = weightGraphViewModel.workoutDoneData.max { item1, item2 in
            return item2.bodyInfo?.weight ?? 0 > item1.bodyInfo?.weight ?? 0
        }?.bodyInfo?.weight ?? 0
        ///데이터 최솟값
        let min = weightGraphViewModel.workoutDoneData.min { item1, item2 in
            return item2.bodyInfo?.weight ?? 0 > item1.bodyInfo?.weight ?? 0
        }?.bodyInfo?.weight ?? 0
        ///우측 정렬을 위한 scrollViewReader
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(weightGraphViewModel.workoutDoneData, id: \.id) { data in
                    LineMark(
                        x: .value("Month", data.date),
                        y: .value("Weight", animate ? data.bodyInfo?.weight ?? 0 : 0)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Color(UIColor.color7442FF))
                    PointMark(
                        x: .value("Month", data.date),
                        y: .value("Weight", animate ? data.bodyInfo?.weight ?? 0 : 0)
                    )
                    ///커스텀 포인트 마크
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
                        RuleMark(x: .value("Month", data.date))
                            .foregroundStyle(Color(UIColor.color7442FF))
                            .lineStyle(.init(lineWidth: 1, lineCap: .round, miterLimit: 2, dash: [2], dashPhase: 5))
                            .annotation(position: .top) {
                                ZStack {
                                    Image("speechBubble")
                                        .resizable()
                                        .frame(width: 50, height: 42)
                                        .offset(y: 6)
                                    Text("\(Int(currentActiveItem.bodyInfo?.weight ?? 0))kg")
                                        .foregroundColor(Color(UIColor.color7442FF))
                                        .font(Font(UIFont.pretendard(.semiBold, size: 14)))
                                }
//                                .offset(x: 0, y: -data.bodyInfo?.weight + 200 - 20)
//                                .offset(x: 0, y: (max / min > 100 ? -(200 - data.weight) : max - data.weight + 40 ))
//                                .offset(x: 0, y: -data.weight + max + 40)
//                                .offset(x: 0, y: (max - data.weight + 40))
//                                .offset(x: 0, y: 220 - data.weight - max) // + 밑, - 위
                            }
                    }
                }
                
    //            .chartXAxis {
    //                AxisMarks(preset: <#T##AxisMarkPreset#>)
    //            }
                .chartYAxis {
                    AxisMarks(position: .trailing)
                }
                .chartYScale(domain: max > 100 ? 0...(max + 100) : 0...(max + 40))
                .chartOverlay(content: { proxy in
                    GeometryReader { innerProxy in
                        Rectangle()
                            .fill(.clear).contentShape(Rectangle())
                            .onTapGesture { value in
                                if let date : String = proxy.value(atX: value.x) {
                                    if let currentItem = weightGraphViewModel.workoutDoneData.first(where: { item in
                                        item.date == date
                                    }) {
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }

                                }
                            }
                    }
                })
                .padding()
                ///데이터 갯수에 따른 차트 UI 구분
                .frame(width: UIScreen.main.bounds.width > ViewConstants.dataPointWidth * CGFloat(weightGraphViewModel.workoutDoneData.count) ? UIScreen.main.bounds.width : ViewConstants.dataPointWidth * CGFloat(weightGraphViewModel.workoutDoneData.count))
                ///우측 정렬을 위한 id 설졍
                .id(trailingID)
            }
            .onAppear {
                ///우측 정렬을 위한 anchor 설정
                proxy.scrollTo(trailingID, anchor: .trailing)
            }
            
        }
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
            weightGraphViewModel.readWeightData()
            
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

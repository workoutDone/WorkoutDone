//
//  FatPercentageGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import Charts

struct TestModel2 {
    var date : Date
    let fatPercentage : Double
}

var list2 = [
    TestModel2(date: "2023.02.01".yyMMddToDate()!, fatPercentage: 20),
    TestModel2(date: "2023.02.02".yyMMddToDate()!, fatPercentage: 22),
    TestModel2(date: "2023.02.03".yyMMddToDate()!, fatPercentage: 24),
    TestModel2(date: "2023.02.04".yyMMddToDate()!, fatPercentage: 20),
    TestModel2(date: "2023.02.05".yyMMddToDate()!, fatPercentage: 20),
    



]

struct FatPercentageGraphView: View {
    ///우측 정렬
    @Namespace var trailingID
    ///더미 데이터
    @State var testData : [TestModel2] = list2
    ///Gesture Property
    @State private var currentActiveItem : TestModel2?
    ///ViewAppear 시 애니메이션 사용 위한 변수
    @State private var animate : Bool = false
    @State private var plotWidth: CGFloat = 0
//        @StateObject var bodyInfoGraphViewModel = BodyInfoGraphViewModel()
    var body: some View {
        ///데이터 최댓값
        let max = testData.max { item1, item2 in
            return item2.fatPercentage > item1.fatPercentage
        }?.fatPercentage ?? 0
        ///데이터 최솟값
        let min = testData.min { item1, item2 in
            return item2.fatPercentage > item1.fatPercentage
        }?.fatPercentage ?? 0
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(testData, id: \.date) { data in
                    LineMark(
                        x: .value("Month", data.date.yyMMddToString()),
                        y: .value("FatPercentage", animate ? data.fatPercentage : 0)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Color(UIColor.color7442FF))
                    PointMark(
                        x: .value("Month", data.date.yyMMddToString()),
                        y: .value("Weight", animate ? data.fatPercentage : 0)
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
                        RuleMark(x: .value("Month", data.date.yyMMddToString()))
                            .foregroundStyle(Color(UIColor.color7442FF))
                            .lineStyle(.init(lineWidth: 1, lineCap: .round, miterLimit: 2, dash: [2], dashPhase: 5))
                            .annotation(position: .top) {
                                ZStack {
                                    Image("speechBubble")
                                        .resizable()
                                        .frame(width: 50, height: 42)
                                        .offset(y: 6)
                                    Text("\(Int(currentActiveItem.fatPercentage))%")
                                        .foregroundColor(Color(UIColor.color7442FF))
                                        .font(Font(UIFont.pretendard(.semiBold, size: 14)))
                                }
//                                .offset(x: 0, y: -data.weight + 200 - 20)
                            }
                    }
                }
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
                                    if let currentItem = testData.first(where: { item in
                                        item.date.yyMMddToString() == date
                                    }) {
                                        print(currentItem.fatPercentage, "sssdd")
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }

                                }
                            }
                    }
                })
                .padding()
                ///데이터 갯수에 따른 차트 UI 구분
                .frame(width: UIScreen.main.bounds.width > ViewConstants.dataPointWidth * CGFloat(testData.count) ? UIScreen.main.bounds.width : ViewConstants.dataPointWidth * CGFloat(testData.count))
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

struct FatPercentageGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FatPercentageGraphView()
    }
}

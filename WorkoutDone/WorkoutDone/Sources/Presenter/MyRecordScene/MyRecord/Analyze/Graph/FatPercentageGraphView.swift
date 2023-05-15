//
//  FatPercentageGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import Charts

struct FatPercentageGraphView: View {
    ///VIewModel
    @StateObject private var fatPercentageViewModel = FatPercentageGraphViewModel()
    ///우측 정렬
    @Namespace var trailingID
    ///Gesture Property
    @State private var currentActiveItem : WorkOutDoneData?
    ///ViewAppear 시 애니메이션 사용 위한 변수
    @State private var animate : Bool = false
    @State private var plotWidth: CGFloat = 0

    var body: some View {
        ///데이터 최댓값
        let max = fatPercentageViewModel.fatPercentageData.max { item1, item2 in
            return item2.bodyInfo?.fatPercentage ?? 0 > item1.bodyInfo?.fatPercentage ?? 0
        }?.bodyInfo?.fatPercentage ?? 0
        ///데이터 최솟값
        let min = fatPercentageViewModel.fatPercentageData.min { item1, item2 in
            return item2.bodyInfo?.fatPercentage ?? 0 > item1.bodyInfo?.fatPercentage ?? 0
        }?.bodyInfo?.fatPercentage ?? 0
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(fatPercentageViewModel.fatPercentageData, id: \.id) { data in
                    LineMark(
                        x: .value("Month", transformDate(date: data.date)),
                        y: .value("FatPercentage", animate ? data.bodyInfo?.fatPercentage ?? 0 : 0)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Color(UIColor.color7442FF))
                    PointMark(
                        x: .value("Month", transformDate(date: data.date)),
                        y: .value("FatPercentage", animate ? data.bodyInfo?.fatPercentage ?? 0 : 0)
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
                    if let fatPercentage = currentActiveItem?.bodyInfo?.fatPercentage,
                       let currentActiveItem, transformDate(date: currentActiveItem.date) == transformDate(date: data.date) {
                        PointMark(
                            x: .value("Month", transformDate(date: data.date)),
                            y: .value("FatPercentage", data.bodyInfo?.fatPercentage ?? 0)
                        )
                            .foregroundStyle(Color(UIColor.color7442FF))
                            .annotation(position: .overlay) {
                                ZStack {
                                    Image("speechBubble")
                                        .resizable()
                                        .frame(width: 50, height: 42)
                                        .offset(y: 6)
                                    Text("\(Int(currentActiveItem.bodyInfo?.fatPercentage ?? 0))%")
                                        .foregroundColor(Color(UIColor.color7442FF))
                                        .font(Font(UIFont.pretendard(.semiBold, size: 14)))
                                }
                                .offset(x: 0, y: -37)
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
                                    if let currentItem = fatPercentageViewModel.fatPercentageData.first(where: { item in
                                        transformDate(date: item.date) == date
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
                .frame(width: UIScreen.main.bounds.width > ViewConstants.dataPointWidth * CGFloat(fatPercentageViewModel.fatPercentageData.count) ? UIScreen.main.bounds.width : ViewConstants.dataPointWidth * CGFloat(fatPercentageViewModel.fatPercentageData.count))
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
            fatPercentageViewModel.readFatPercentageData()
            for (index, _) in fatPercentageViewModel.fatPercentageData.enumerated() {
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
    func transformDate(date : String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 2)
        let transformDate = date[startIndex...]
        return String(transformDate)
    }
}

struct FatPercentageGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FatPercentageGraphView()
    }
}

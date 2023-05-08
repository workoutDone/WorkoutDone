//
//  SkeletalMuscleMassGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import Charts


struct SkeletalMuscleMassGraphView: View {
    ///ViewModel
    @StateObject private var skeletalMusleMassGraphViewModel = SkeletalMuslemassGraphViewModel()
    ///우측 정렬
    @Namespace var trailingID
    ///Gesture Property
    @State private var currentActiveItem : WorkOutDoneData?
    ///ViewAppear 시 애니메이션 사용 위한 변수
    @State private var animate : Bool = false
    @State private var plotWidth : CGFloat = 0
    
    
    var body: some View {
        ///데이터 최댓값
        let max = skeletalMusleMassGraphViewModel.skeletalMusleMassData.max { item1, item2 in
            return item2.bodyInfo?.skeletalMuscleMass ?? 0 > item1.bodyInfo?.skeletalMuscleMass ?? 0
        }?.bodyInfo?.skeletalMuscleMass ?? 0
        ///데이터 최솟값
        let min = skeletalMusleMassGraphViewModel.skeletalMusleMassData.min { item1, item2 in
            return item2.bodyInfo?.skeletalMuscleMass ?? 0 > item1.bodyInfo?.skeletalMuscleMass ?? 0
        }?.bodyInfo?.skeletalMuscleMass ?? 0
        ///우측 정렬을 위한 scrollViewReader
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(skeletalMusleMassGraphViewModel.skeletalMusleMassData, id: \.id) { data in
                    LineMark(
                        x: .value("Month", data.date),
                        y: .value("SkeletalMuclsMass", animate ? data.bodyInfo?.skeletalMuscleMass ?? 0 : 0)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Color(UIColor.color7442FF))
                    PointMark(
                        x: .value("Month", data.date),
                        y: .value("SkeletalMuclsMass", animate ? data.bodyInfo?.skeletalMuscleMass ?? 0 : 0)
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
                    if let skeletalMusleMass = currentActiveItem?.bodyInfo?.skeletalMuscleMass,
                       let currentActiveItem, currentActiveItem.date == data.date {
                        RuleMark(x: .value("Month", data.date))
                            .foregroundStyle(Color(UIColor.color7442FF))
                            .lineStyle(.init(lineWidth: 1, lineCap: .round, miterLimit: 2, dash: [2], dashPhase: 5))
                            .annotation(position: .top) {
                                ZStack {
                                    Image("speechBubble")
                                        .resizable()
                                        .frame(width: 50, height: 42)
                                        .offset(y: 6)
                                    Text("\(Int(currentActiveItem.bodyInfo?.skeletalMuscleMass ?? 0))kg")
                                        .foregroundColor(Color(UIColor.color7442FF))
                                        .font(Font(UIFont.pretendard(.semiBold, size: 14)))
                                }
                                .offset(x: 0, y: 25)
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
                                    if let currentItem = skeletalMusleMassGraphViewModel.skeletalMusleMassData.first(where: { item in
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
                .frame(width: UIScreen.main.bounds.width > ViewConstants.dataPointWidth * CGFloat(skeletalMusleMassGraphViewModel.skeletalMusleMassData.count) ? UIScreen.main.bounds.width : ViewConstants.dataPointWidth * CGFloat(skeletalMusleMassGraphViewModel.skeletalMusleMassData.count))
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
            skeletalMusleMassGraphViewModel.readSkeletalMusleMassData()
            for (index, _) in skeletalMusleMassGraphViewModel.skeletalMusleMassData.enumerated() {
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
        


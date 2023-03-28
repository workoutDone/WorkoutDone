//
//  FatPercentageGraphView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import Charts



struct FatPercentageGraphView: View {
        func formatDate(_ date: Date) -> String {
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
//        @StateObject var bodyInfoGraphViewModel = BodyInfoGraphViewModel()
        //제스처 프로퍼티
        @State var currentActiveItem: TestModel?
        @State var testData : [TestModel] = list
        @State var animate: Bool = false
        @State var plotWidth: CGFloat = 0
        
        var body: some View {
            let max = testData.max { item1, item2 in
                return item2.weight ?? 0 > item1.weight ?? 0
            }?.weight ?? 0
            Chart(testData, id: \.date) { data in
                LineMark(
                    x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())),
                    y: .value("Weight", animate ? data.weight : 0)
                )
                .interpolationMethod(.cardinal) //둥근 선
                .foregroundStyle(.red)
                PointMark(
                    x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())),
                    y: .value("Weight", animate ? data.weight : 0)
                ).foregroundStyle(.black)
                    .symbolSize(5)
    //            if let currentActiveItem, currentActiveItem.createdDate == data.createdDate {
    ////                RuleMark(x: .value("weight", currentActiveItem?.weight!))
    //                RuleMark(x: .value("Weight", currentActiveItem.weight ?? 0))
    //            }
    //            RuleMark(x: .value("Month", currentActiveItem?.createdDate ?? ""))
                if let currentActiveItem, currentActiveItem.date == data.date {
                    RuleMark(x: .value("Month", formatDate(dateFormatter.date(from: data.date) ?? Date())))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .annotation(position: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("몸무게")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(currentActiveItem.weight ?? 0)")
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
    //                    .offset(x: (plotWidth / CGFloat(bodyInfoGraphViewModel.bodyInfo.count)) / 2)
                    
                }
            }.chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYScale(domain: 0...(max + 50)) //그래프의 최대값을 조절
            .chartOverlay { proxy in
                GeometryReader { innerProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    //현재 위치 얻기
                                    let location = value.location
                                    //Extracting Value From The Location
                                    //Swift Charts Gives The Direct Ability to do that
                                    // We're going to extract the Date in A-Axis Then with the help of That Date Value We're extracting the current Items
                                    if let weight: Double = proxy.value(atY: location.y) {
                                        if let currentItem = testData.first(where: { item in
                                            item.weight == weight
                                        }) {
                                            self.currentActiveItem = currentItem
    //                                        self.plotWidth = proxy.plotAreaSize.width
                                            print(currentActiveItem?.weight, "ss")
                                        }
                                    }
                                }).onEnded({ value in
                                    self.currentActiveItem = nil
                                })
                        )
                }
            }
            .frame(height: 300)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white.shadow(.drop(radius: 2)))
            }
            .padding()
            .onAppear {
                for (index, _) in testData.enumerated() {
                    withAnimation(.easeInOut(duration: 0.8).delay(Double(index) * 0.05)) {
                        animate = true
                        print(testData, "???")
                    }
                }
            }
            .onDisappear {
                animate = false
            }
        }
}

struct FatPercentageGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FatPercentageGraphView()
    }
}

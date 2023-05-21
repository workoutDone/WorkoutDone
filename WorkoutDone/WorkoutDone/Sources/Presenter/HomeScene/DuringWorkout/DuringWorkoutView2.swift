//
//  DuringWorkoutView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/19.
//

//import SwiftUI
//import UIKit
//
//
//struct DuringWorkoutView2: View {
//    ///Animation Properties
//    @State private var expandSheet : Bool = false
//    @Namespace private var animation
//    
//    var tabBarHeight : Double
//    var body: some View {
//        VStack {
//            CustomBottomSheet()
//                .overlay {
//                    if expandSheet {
//                        DurgingWorkoutExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
//                        ///Transition for more flunet Animation
//                            .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
//                    }
//                }
//        }
//    }
//    
//    ///Custom Bottom Sheet
//    @ViewBuilder
//    func CustomBottomSheet() -> some View {
//        ZStack {
//            Rectangle()
//                .fill(.ultraThinMaterial)
//                .overlay {
//                    ///Music Info
//                    MusicInfo(expandSheet: $expandSheet, animation: animation)
//                }
//            
//        }
//        .frame(height: 70)
////                .offset(y: -49)
//        ///Separator Line
//        .overlay(alignment: .bottom, content: {
//            Rectangle()
//                .fill(.gray.opacity(0.3))
//                .frame(height: 1)
//                .offset(y: -5)
//        })
////        .offset(y: -tabBarHeight)
//    }
//}
//
//struct DuringWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        DuringWorkoutView2(tabBarHeight: 30)
//    }
//}
//
///// Resuable File
//struct MusicInfo: View {
//    @Binding var expandSheet: Bool
//    var animation: Namespace.ID
//    var body: some View {
//        HStack(spacing: 0) {
//            /// Adding Mached Geometry Effect
//            ZStack {
//                if !expandSheet {
//                    GeometryReader {
//                        let size = $0.size
//                        
//                        Image("galleryImage")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: size.width, height: size.height)
//                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
//                    }
//                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
//                }
//            }
//            .frame(width: 45, height: 45)
//            
//            Text("Look What you Made me do")
//                .fontWeight(.semibold)
//                .lineLimit(1)
//                .padding(.horizontal, 15)
//            
//            Spacer(minLength: 0)
//            
//            Button {
//                
//            } label: {
//                Image(systemName: "pause.fill")
//                    .font(.title2)
//            }
//            Button {
//                
//            } label: {
//                Image(systemName: "forward.fill")
//                    .font(.title2)
//            }
//            .padding(.leading, 25)
//        }
//        .foregroundColor(.primary)
//        .padding(.horizontal)
//        .padding(.bottom, 5)
//        .frame(height: 70)
//        .contentShape(Rectangle())
//        .onTapGesture {
//            /// Expanding Bottom Sheet
//            withAnimation(.easeInOut(duration: 0.3)) {
//                expandSheet = true
//            }
//        }
//    }
//}
//     

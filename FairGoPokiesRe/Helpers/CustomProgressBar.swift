//
//  CustomProgressBar.swift
//  FairGoPokies
//
//  Created by Oleksii  on 30.05.2024.
//

import SwiftUI

struct CustomProgressBar: View {
    var progress: Int
    
    private let segmentCount = 8
    
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(Color(hex: "082253"))
            .frame(height: 20)
            .shadow(color: Color(hex: "71E3F3").opacity(0.75), radius: 4, x: 0, y: 0)
            
            .overlay {
                GeometryReader { geometry in
                    HStack(spacing: 2) {
                        ForEach(0..<self.segmentCount) { index in
                            Rectangle()
                                .fill(self.segmentColor(for: index))
                                .frame(width: self.segmentWidth(in: geometry.size.width))
                        }
                    }
                    .cornerRadius(24)
                    .padding(2)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(hex: "71E3F3"), lineWidth: 1)
            }
    }
    
    private func segmentColor(for index: Int) -> LinearGradient {
        let segmentProgress = Double(index + 1) / Double(segmentCount)
        return progress >= index+1 ? Color.greenGradient : LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom)
    }
    
    private func segmentWidth(in totalWidth: CGFloat) -> CGFloat {
        (totalWidth - CGFloat(segmentCount - 1) * 2) / CGFloat(segmentCount)
    }
}

#Preview {
    MainView()
}

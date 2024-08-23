//
//  Button.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var color: LinearGradient
    var strokeColor: LinearGradient
    var fontColor: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .foregroundStyle(color)
            .frame(height: 44)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(strokeColor, lineWidth: 3)
            }
            .overlay {
                Text(text)
                    .foregroundStyle(fontColor)
                    .font(.custom("JosefinSans-Medium", size: 20))
            }
    }
}

#Preview {
    CustomButton(text: "Settings", color: Color.yellowGradient, strokeColor: Color.lightBlueGradient, fontColor: Color.white)
}

struct BackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action){
            Image("BackBTN")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.green)
        }
    }
}

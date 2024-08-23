//
//  Balance.swift
//  FairGoPokies
//
//  Created by Oleksii  on 31.05.2024.
//

import SwiftUI

struct Balance: View {
    @AppStorage("balance") var balance: Int = 0
    var body: some View {
        VStack(spacing: 4) {
            Image("coin")
                .resizable()
                .frame(width: 40, height: 40)
            Text("\(balance)")
                .font(.custom("JosefinSans-Medium", size: 20))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    Balance()
}

//
//  PriceCardView.swift
//  studenttestapp
//
//  Created by Nikos Stauropoulos on 18.06.24.
//

import SwiftUI

struct PriceCardView: View {
    
    @Binding var billWithTip : String
    @Binding var totalTip : String
    @Binding var tipPercent : Int
    @Binding var originalBill : String
    @Binding var totalBill: String
    @Binding var billPersons: Int
    
    
    
    
    
    var body: some View {
        VStack{
            Group{
                Text("Total Per Person: \(billWithTip)$")
                Text("Grand Total: \(totalBill)$")
            }
            .font(.title2)
            Group{
                Text("Bill: \(originalBill)$")
                Text("Tip: \(totalTip) (\(tipPercent)%)")
                Text("Split by: \(billPersons)")
            }
            .opacity(0.8)
        }
        .frame(width: 350,height: 170)
        .background(Color.app)
        .cornerRadius(20)
        
    }
}

#Preview {
    PriceCardView(billWithTip: .constant("0"),totalTip: .constant("10"), tipPercent: .constant(10),originalBill: .constant("10"),totalBill: .constant("10"),billPersons: .constant(10))
}

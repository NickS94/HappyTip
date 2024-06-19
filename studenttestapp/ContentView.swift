//
//  ContentView.swift
//  studenttestapp
//
//  Created by Nikos Stauropoulos on 17.06.24.
//

import SwiftUI

struct ContentView: View {
    @State var bill :String = ""
    @State var selectedTipPercent = 5
    @State var personsSplitToBill = 1
    
    @State var billWithTip :String = "0.00"
    
    @State var totalBill :String = "0.00"
    
    @State var tip :String = "0.00"
    
    let step = 1
    let range = 1...20
    
    
    let formatter :NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    var body: some View {
        
        VStack (spacing:30){
            Text("Happy Tipper")
                .font(.title2)
                .bold()
            PriceCardView(
                billWithTip: $billWithTip,
                totalTip: $tip,
                tipPercent: $selectedTipPercent,
                originalBill: $bill,
                totalBill: $totalBill,
                billPersons: $personsSplitToBill)
            
            
            VStack(alignment:.leading){
                Text("Enter your total bill amount.")
                TextField("", text: $bill)
                    .font(.system(size: 18))
                    .padding(10)
                    .frame(width: 350, height: 50)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment:.leading){
                    Text("Select desired tip percent %")
                    Picker("Tip", selection: $selectedTipPercent) {
                        Text("5%").tag(5)
                        Text("10%").tag(10)
                        Text("20%").tag(20)
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                VStack(alignment:.leading){
                    Text("Want to split the bill?")
                        .foregroundStyle(.gray)
                    Stepper(value: $personsSplitToBill, in: range,step: step) {
                        HStack{
                            Text("Split by Persons:")
                            Text("\(personsSplitToBill)").font(.title2)
                        }
                    }
                }
                
            }
            Button(action: {
                calculateTip()
            }, label: {
                Text("Calculate")
                    .frame(width:350,height: 40)
                    .background(Color.appPink)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            })
            
            Button(action: {
                cancelCalculation()
            }, label: {
                Text("Cancel")
                    .frame(width:350,height: 40)
                    .foregroundStyle(Color.white)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            })
        }
        .padding(.leading,20)
        .padding(.trailing,20)
    }
    
    func calculateTip( ){
        
        guard let billAmountNumber = formatter.number(from: bill) else{
            return
        }
        
        let billAmount = Float(truncating: billAmountNumber)
        let tipPercentage = Float(selectedTipPercent) / 100
        let tipAmount = billAmount * tipPercentage
        let totalBillWithTip = billAmount + tipAmount
        
        var billWithTip :Float = 0.0
        
        if personsSplitToBill > 1 {
            billWithTip = totalBillWithTip / Float(personsSplitToBill)
        }else{
            billWithTip = totalBillWithTip
        }
        
        self.billWithTip = formatter.string(from: NSNumber(value: billWithTip)) ?? "0.00$"
        
        self.totalBill = formatter.string(from: NSNumber(value: totalBillWithTip)) ?? "0.00$"
        
        self.tip = formatter.string(from: NSNumber(value: tipAmount)) ?? "0.00$"
        
    }
    
    func cancelCalculation( ){
        billWithTip = "0.00"
        totalBill = "0.00"
        tip = "0.00"
    }
}
#Preview {
    ContentView()
}

//
//  ContentView.swift
//  BillsplitR
//
//  Created by Armando Francisco on 10/19/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5,10,15,20,25,0]
    
    private var calculatedMath: (totalPerPerson: Double, grandTotal: Double, tipPerPerson: Double) {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        let totalPerPerson = grandTotal / peopleCount
        let tipPerPerson = tipValue / peopleCount
        
        return (totalPerPerson,grandTotal,tipPerPerson)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    
                    TextField("Bill Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Tip Percentage") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Text("Tip x Person")
                        Text(calculatedMath.tipPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                
                Section("Total Per Person") {
                    Text(calculatedMath.totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Grand Total") {
                    Text(calculatedMath.grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("BillsplitR").fontDesign(.monospaced)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
    

}

#Preview {
    ContentView()
}

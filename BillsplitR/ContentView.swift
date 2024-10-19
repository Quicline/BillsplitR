//
//  ContentView.swift
//  BillsplitR
//
//  Created by Armando Francisco on 10/19/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    let tipPercentages = [5,10,15,20,25,0]
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Bill Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Button("press") {
                        print(numberOfPeople)
                    }
                }
                
                Section {
                    Text(billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
        }
    }
    

}

#Preview {
    ContentView()
}

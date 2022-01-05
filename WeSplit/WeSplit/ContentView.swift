//
//  ContentView.swift
//  WeSplit
//
//  Created by John McCants on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                    .focused($amountIsFocused)
                    .keyboardType(.decimalPad)
            }
            Section {
                Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    
                }
            Section {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("How much tip do you want to leave?")
            }
            Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2 ..< 100) {
                        Text("\($0) people")
                    }
                }
         
        }
        .navigationTitle("Tip Calculator")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
            }
        }
    }
    }
    
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

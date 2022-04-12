//
//  ContentView.swift
//  Shared
//
//  Created by Freak on 07.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    var tipPercentages = [0, 10, 15, 20, 25]
    var checkTotal: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * (tipSelection + 2)
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = checkTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 101) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("The check amount is: ")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(2 ..< 100) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(checkTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("The grand total is")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header:{
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
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

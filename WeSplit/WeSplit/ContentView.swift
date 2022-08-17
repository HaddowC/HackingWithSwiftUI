//
//  ContentView.swift
//  WeSplit
//
//  Created by Calum Haddow on 23/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    //let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // Calculate the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Challenge 2
    var totalWithTip: Double {
        // Calculate the total per person
        let total = checkAmount
        let tipSelection = Double(tipPercentage)
        
        let value = tipSelection / 100
        let tss = total * value
        let amount = total + tss
        
        return amount
    }
    
    //EXTRA CHALLENGE
    var formatter: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
        
    }
    
    var body: some View {
        
        // START OF NAVIGATIONVIEW
        NavigationView {
        
            // START OF FORM
            Form {
                
                // START OF SECTION-1
                Section {
                    TextField("Amount", value: $checkAmount, format: formatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } // END OF SECTION-1
                
                // START OF SECTION-2 Challenge 3
                Section {
                    
                    Picker("Tip Selection", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                                
                        }
                    }
                } // END OF SECTION-2
                
                /*
                // START OF SECTION-2
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave")
                }
                // END OF SECTION-2
                 */
               
                // START OF SECTION-3
                Section {
                    Text(totalWithTip, format: formatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .white)
                }
                // **CHALLENGE 1
                header: {
                    Text("Total with Tip:")
                }
                // END OF SECTION-3
                
                // START OF SECTION-4
                Section {
                    Text(totalPerPerson, format: formatter)
                }
                // **CHALLENGE 1
                header: {
                    Text("Amount Per Person:")
                }
                // END OF SECTION-4
                
            
            } // END OF FORM
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
            
        } // END OF NAVIGATIONVIEW

    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

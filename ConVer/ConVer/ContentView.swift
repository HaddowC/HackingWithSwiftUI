//
//  ContentView.swift
//  ConVer
//
//  Created by Calum Haddow on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var value = 0.0
    @State private var unit = Length.m
    @State private var convertedUnit = Length.km
    @FocusState private var isFocused: Bool
    
    let units = Length.array
    
     var convertedValue: String {
        
         var result = Measurement(value: value, unit: unit.measurement)
         
         result.convert(to: convertedUnit.measurement)
         let formattedValue = String(format: "%.4f", result.value)
         
         return "\(formattedValue) \(convertedUnit.name)"
         
     }
    
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    TextField("Enter Value: ", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Select Unit", selection: $unit) {
                        ForEach(units, id: \.self) { m in
                            Text("\(m.name)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Original Value")
                }
                
                Section {
                    Text("\(convertedValue)")
                    
                    Picker("Change Conversion", selection: $convertedUnit) {
                        ForEach(units, id: \.self) { m in
                            Text("\(m.name)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Converter")
                }
                
            }
            .navigationTitle("ConVer")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        isFocused = false
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

//
//  ContentView.swift
//  UnitConversions
//
//  Created by Muhamamd Nurasid on 27/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = "Celcius"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var isInputNumberFocused: Bool
    
    let units = ["Celcius", "Fahrenheit", "Kelvin"]
    
    func toCelcius(value: Double) -> Double {
        switch(inputUnit) {
        case units[1]:
            return 5/9 * (value - 32)
        case units[2]:
            return value - 273.15
        default:
            return value
        }
    }
    
    var convert: Double {
        let celciusValue = toCelcius(value: inputNumber)
        
        switch(outputUnit) {
        case units[1]:
            return 9 / 5 * celciusValue + 32
        case units[2]:
            return celciusValue + 273.15
        default:
            return celciusValue
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Temperature", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputNumberFocused)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(convert.formatted())
                }
            }
            .navigationTitle("Temperature Conversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isInputNumberFocused {
                    Button("Done") {
                        isInputNumberFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

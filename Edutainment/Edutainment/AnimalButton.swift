//
//  AnimalButton.swift
//  Edutainment
//
//  Created by Calum Haddow on 27/08/2022.
//

import Foundation
import SwiftUI

struct AnimalButton: View {
    
    var animal: String
    var number: Int
    
    
    var body: some View {
      
    VStack(spacing: 10) {
       Image(animal)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 5)
            .contentShape(Rectangle())
            .padding(.vertical,5)
        
        Text("\(number)")
            .font(.title2.bold())
        
        }
    }
}

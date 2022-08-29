//
//  BlueButton.swift
//  Edutainment
//
//  Created by Calum Haddow on 29/08/2022.
//

import Foundation
import SwiftUI

struct BlueButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(width: 100, height: 50)
            .foregroundColor(.black)
            .background {
                     RoundedRectangle(cornerRadius: 15, style: .continuous)
                         .fill(Color("Blue"))
                 }
            
    }
    
}

extension View {
    func blueButton() ->  some View {
        modifier(BlueButton())
    }
}
    
    




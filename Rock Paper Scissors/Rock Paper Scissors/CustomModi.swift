//
//  CustomModi.swift
//  Rock Paper Scissors
//
//  Created by Calum Haddow on 10/08/2022.
//

import Foundation
import SwiftUI

struct CustomModi: ViewModifier {
    
    func body(content: Content) -> some View {
            
        content
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    
}

extension View {
    func modi() -> some View {
        modifier(CustomModi())
    }
}

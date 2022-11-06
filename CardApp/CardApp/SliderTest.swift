//
//  SliderTest.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 01.11.2022.
//

import SwiftUI

struct SliderTest: View {
    
    @State var score: Int = 0
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            //returns the score as a Double
            return Double(score)
        }, set: {
            //rounds the double to an Int
            print($0.description)
            score = Int($0)
        })
    }
    
    var body: some View {
        VStack{
            Text(score.description)
            
            Slider(value: intProxy , in: 0.0...10.0, step: 1.0, onEditingChanged: {_ in
                print(score.description)
            })
            .tint(Color.green)
            .frame(height: 30)
        }
    }
}

struct SliderTest_Previews: PreviewProvider {
    static var previews: some View {
        SliderTest()
    }
}

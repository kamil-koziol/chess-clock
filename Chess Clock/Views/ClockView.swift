//
//  Clock.swift
//  Chess Clock
//
//  Created by Kamil Kozioł on 05/04/2021.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var counter: Int;
    
    var body: some View {
        Text(TimeUtils.secondsAsTime(seconds: counter))
            .frame(
                minWidth:0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .font(Font.system(size: 60).bold())
    }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(counter: Binding.constant(10))
        ClockView(counter: Binding.constant(100))
        ClockView(counter: Binding.constant(4000))
    }
}

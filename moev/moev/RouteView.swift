//
//  RouteView.swift
//  moev
//
//  Created by Simon Chervenak on 12/7/23.
//

import Foundation
import SwiftUI

struct RouteView: View {
    @State public var route: CombinedRoute
    
    var body: some View {
        VStack {
            ForEach(route.legs ?? []) { leg in
                stepsList(leg.steps)
            }
            Text("Leave at \(route.startTime.format("hh:mm"))")
        }
    }
    
    func stepsList(_ steps: [CombinedStep]) -> some View {
        return ZStack {
            ForEach(steps) { step in
                stepsView(step)
                    .position(x: CGFloat(xposition(for: step)), y: 10)
            }
        }
        .frame(width: CGFloat(xposition(for: route.maxDuration)))
//        .position(x: CGFloat(xposition(for: route.durationFromNow)), y: 10)
//        .offset(x: CGFloat(xposition(for: time(date: route.startTime))))
    }
    
    func stepsView(_ step: CombinedStep) -> some View {
        return VStack {
            if let td = step.transitDetails {
                VStack {
                    Text(td.transitLine!.nameShort!)
                        .foregroundColor(Color(hex: td.transitLine!.textColor!)) // Set text color using hex value
                        .lineLimit(1)
                        .font(.system(size: 12))
                }
                .frame(width: CGFloat(width(for: step)))
                .background(Color(hex: td.transitLine!.color!)) // Set background color using hex value
            }
            else if let tm = step.travelMode {
                tm.to_swiftui_image()
                    .frame(width: CGFloat(width(for: step)))
                    .border(.black, width: 2)
            }
        }
    }
}

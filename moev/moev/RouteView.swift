//
//  RouteView.swift
//  moev
//
//  Created by Simon Chervenak on 12/7/23.
//

import Foundation
import SwiftUI

struct RouteView: View {
    @State public var route: Route
    
    var body: some View {
        ForEach(route.legs ?? []) { leg in
            if let steps = leg.steps {
                stepsList(steps)
            }
        }
    }
    
    func stepsList(_ steps: [RouteLegStep]) -> some View {
        return ZStack {
            ForEach(combineWalks(steps: steps, route: route)) { step in
                stepsView(step)
                    .position(x: CGFloat(xposition(for: step)), y: 10)
            }
        }
    }
    
    func stepsView(_ step: CombinedStep) -> some View {
        return VStack {
            if let td = step.transitDetails {
                Text(td.transitLine!.nameShort!)
//                    .padding()
                    .background(Color(hex: td.transitLine!.color!)) // Set background color using hex value
                    .foregroundColor(Color(hex: td.transitLine!.textColor!)) // Set text color using hex value
                    .frame(width: CGFloat(width(for: step)))
                    .border(.black, width: 2)
                    .lineLimit(1)
                    .font(.system(size: 12))
            }
            else if let tm = step.travelMode {
                tm.to_swiftui_image()
                    .frame(width: CGFloat(width(for: step)))
                    .border(.black, width: 2)
            }
        }
    }
}

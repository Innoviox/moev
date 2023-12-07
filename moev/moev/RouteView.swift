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
//        HStack {
            ForEach(route.legs ?? []) { leg in
                if let steps = leg.steps {
                    stepsList(steps)
                }
            }
//        }
    }
    
    func stepsList(_ steps: [RouteLegStep]) -> some View {
        return HStack {
            ForEach(combineWalks(steps: steps)) { step in
                stepsView(step)
                    .offset(x: CGFloat(xposition(for: time(timestamp: step.transitDetails?.stopDetails?.departureTime) ?? 0)))
            }
        }
    }
    
    func stepsView(_ step: CombinedStep) -> some View {
        return VStack {
            if let tm = step.travelMode {
                tm.to_swiftui_image()
                    .frame(width: CGFloat(xposition(for: step.totalDuration)))
                    .border(.black, width: 2)
            }

//            Text(String(step.totalDuration))
        }
    }
}

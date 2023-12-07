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
        ScrollView(.horizontal) {
            HStack {
                ForEach(route.legs ?? []) { leg in
                    if let steps = leg.steps {
                        stepsList(steps)
                    }
                }
            }
        }
    }
    
    func stepsList(_ steps: [RouteLegStep]) -> some View {
        return ForEach(combineWalks(steps: steps)) { step in
            stepsView(step)
        }
    }
    
    func stepsView(_ step: CombinedStep) -> some View {
        return VStack {
            if let tm = step.travelMode {
                tm.to_swiftui_image()
            }

            Text(String(step.totalDuration))
        }
    }
}

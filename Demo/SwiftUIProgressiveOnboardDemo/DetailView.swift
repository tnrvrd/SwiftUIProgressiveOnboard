//
//  DetailView.swift
//  SwiftUIProgressiveOnboardDemo
//
//  Created by muhammed on 17/11/2020.
//

import SwiftUI
import SwiftUIProgressiveOnboard

// Step 1: Set your data in Detail View
let detailViewProgressiveOnboardsJson = """
[
    {
        "description": "Onboarding in Detail View",
        "previousButtonTitle": "",
        "nextButtonTitle": "Next"
    },
    {
        "description": "This is the last one",
        "previousButtonTitle": "Previous",
        "nextButtonTitle": "Done"
    }
]
"""


struct DetailView: View {
    
    // Step 2: Create an observable ProgressiveOnboard object with your data
    @ObservedObject var onboardDetailView = ProgressiveOnboard.init(withJson: detailViewProgressiveOnboardsJson)
    
    var body: some View {
        
        // Step 3: Create a ZStack for overlay
        ZStack {
            
            VStack {
                Button(action: {
                    self.onboardDetailView.showOnboardScreen = true
                }) {
                    Text("START SWIFTUI PROGRESSIVE ONBOARD")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                }
                .padding(.top, 50)
                
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                            .font(.title)
                        Text("Onboard 1 in Detail View")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(40)
                }
                // Step 4: Add you progressiveOnboard
                .background(ProgressiveOnboardGeometry(withRect: $onboardDetailView.filterViews[0]))
                
                
                Text("Text in Detail View")
                    .padding()
                    // Step 4: Add you progressiveOnboard
                    .background(ProgressiveOnboardGeometry(withRect: $onboardDetailView.filterViews[1]))
            }
            
            // Step 5: Show your onboard view at the top of ZStack
            if(onboardDetailView.showOnboardScreen) {
                ProgressiveOnboardView.init(withProgressiveOnboard: self.onboardDetailView)
            }
            
        }
        // Step 6: Specify the coordinate space for the Geometry Reader
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .coordinateSpace(name: "OnboardSpace")
        .onAppear() {
            // Start onboard on appear
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { /// Delay for the UI did load
                self.onboardDetailView.showOnboardScreen = true
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

//
//  ContentView.swift
//  SwiftUIProgressiveOnboardDemo
//
//  Created by muhammed on 19/10/2020.
//

import SwiftUI
import SwiftUIProgressiveOnboard


// Step 1: Set your data
let progressiveOnboardsJson = """
[
    {
        "description": "You can use onboard screens. This is the first onboard text. Let's make it longer with the same text. You can use onboard screens. This is the first onboard text.",
        "previousButtonTitle": "",
        "nextButtonTitle": "Next"
    },
    {
        "description": "This is the second one, go down for a button",
        "previousButtonTitle": "Previous",
        "nextButtonTitle": "Go"
    },
    {
        "description": "This is top text align right",
        "previousButtonTitle": "Pre",
        "nextButtonTitle": "Go"
    },
    {
        "description": "Image align left",
        "previousButtonTitle": "Go Back",
        "nextButtonTitle": "Next"
    },
    {
        "description": "... and this is the last one. When you click finish button it will be automatically closed.",
        "previousButtonTitle": "Back",
        "nextButtonTitle": "FINISH!"
    }
]
"""

struct ContentView: View {
    
    // Step 2: Create an observable ProgressiveOnboard object with your data
    @ObservedObject var onboard = ProgressiveOnboard.init(withJson: progressiveOnboardsJson)
    
    var body: some View {
        
        // Step 3: Create a ZStack for overlay
        ZStack {
            
            VStack {
                
                Button(action: {
                    self.onboard.showOnboardScreen = true
                }) {
                    Text("START SWIFTUI PROGRESSIVE ONBOARD")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                }
                .padding(.top, 50)
                
                
                Text("Onboard 1: Simple text with padding!")
                    .padding()
                    // Step 4: Add your progressiveOnboard
                    // FilterViews are automatically created by the given data count
                    .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[0]))
                
                HStack {
                    Spacer()
                    
                    Text("Onboard 2: Align right")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                        .border(Color.purple, width: 5)
                        // Step 4: Add you progressiveOnboard
                        .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[2]))
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "sun.max")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        // Step 4: Add you progressiveOnboard
                        .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[3]))
                    
                    Spacer()
                }
                
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                            .font(.title)
                        Text("Onboard 4: A Button")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(40)
                }
                // Step 4: Add you progressiveOnboard
                .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[1]))
                
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "person.3")
                            .font(.title)
                        Text("Full Width Button")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                }
                // Step 4: Add you progressiveOnboard
                .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[4]))
                
                Spacer()
                
            }
            
           
            // Step 5: Show your onboard view at the top of ZStack
            if(onboard.showOnboardScreen) {
                ProgressiveOnboardView.init(withProgressiveOnboard: self.onboard)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color(#colorLiteral(red: 0.8486280441, green: 0.9037795663, blue: 0.9840080142, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

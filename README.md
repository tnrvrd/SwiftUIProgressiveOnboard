# SwiftUIProgressiveOnboard

SwiftUIProgressiveOnboard is designed for progressive onboards in SwiftUI.

![](https://media.giphy.com/media/pPfjQcLuHYANJZBIIj/giphy.gif)

## Installation

Swift Package Manager

Open your project in Xcode, click File -> Swift Packages -> Add Package Dependency, enter the repo's URL.

```
https://github.com/muhammedtanriverdi/SwiftUIProgressiveOnboard.git
```

## Usage

Import the library
```
import SwiftUIProgressiveOnboard   
```

**STEP 1:** Set your data as a json format string

```
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
    }
]	
"""
```

**STEP 2:** Create an observable ProgressiveOnboard object with your data

```
@ObservedObject var onboard = ProgressiveOnboard.init(withJson: progressiveOnboardsJson)
```

**STEP 3:** Create a ZStack for overlay
```
var body: some View {
    ZStack {

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .edgesIgnoringSafeArea(.all)
}
```

**STEP 4:** Add progressive board views to the buttons, texts, views... (filterViews are automatically created by the given data count)
```
var body: some View {
    ZStack {
    	VStack {
        	Text("Lorem Ipsum 1")
        		.background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[0]))


        	Button("Simple Button") {}
            	.background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[1]))
    	}
    }
}
```

**STEP 5:** Show your onboard view at the top of ZStack
```
var body: some View {
    ZStack {
    	VStack {
        	Text("Lorem Ipsum 1")
        		.background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[0]))


        	Button("Simple Button") {}
            	.background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[1]))
    	}

    	if(onboard.showOnboardScreen) {
            ProgressiveOnboardView.init(withProgressiveOnboard: self.onboard)
        }
    }
}
```


**USING ON DETAIL VIEW**
If you want to use it in another view, you can follow the same steps from the beginning. 
You also need to define the coordinate system as "OnboardSpace" for the GeometryReader for the ZStack.

**STEP 6:** 
```
ZStack {
    ...
}
.frame(maxWidth: .infinity, maxHeight: .infinity)
.coordinateSpace(name: "OnboardSpace")
``` 

## Licence
SwiftUIProgressiveOnboard is available under the MIT license. See the LICENSE file for more info.



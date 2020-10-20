//
//  OnboardView.swift
//  Animation Samples
//
//  Created by muhammed on 19/10/2020.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ProgressiveOnboardGeometry: View {
    @Binding public var rect: CGRect
    
    public init(withRect: Binding<CGRect>) {
        self._rect = withRect
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        )
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public class ProgressiveOnboard: ObservableObject {
    @Published public var showOnboardScreen = false
    @Published private var activeIndex = 0
    
    fileprivate var animateDuration: Double = 0.5
    
    fileprivate var onboardItems = [OnboardItem]()
    public var filterViews = [CGRect]()
    
    public init(withJson: String) {
        setup(withJson: withJson)
    }
    
    public init(withJson: String, animateDuration: Double) {
        setup(withJson: withJson)
        self.animateDuration = animateDuration
    }
    
    private func setup(withJson: String) {
        do {
            let data = withJson.data(using: .utf8)
            let decoder = JSONDecoder()
            onboardItems = try decoder.decode([OnboardItem].self, from: data!)
            
            for _ in 0..<onboardItems.count {
                filterViews.append(CGRect())
            }
        } catch {
            print("error:\(error)")
        }
    }
    
    fileprivate func handlePrevious() {
        if activeIndex > 0 {
            activeIndex -= 1
        }
    }
    
    fileprivate func handleNext() {
        if activeIndex+1 == onboardItems.count {
            // End onboard screens
            activeIndex = 0
            self.showOnboardScreen = false
        } else {
            activeIndex += 1
        }
    }
    
    fileprivate var filterView: CGRect {
        return filterViews[activeIndex]
    }
    
    fileprivate var description: String {
        return onboardItems[activeIndex].description
    }
    
    fileprivate var nextButtonTitle: String {
        return onboardItems[activeIndex].nextButtonTitle
    }
    
    fileprivate var previousButtonTitle: String {
        return onboardItems[activeIndex].previousButtonTitle
    }
    
    fileprivate var positionX: CGFloat {
        return UIScreen.main.bounds.midX
    }
    
    fileprivate func positionY(contentView: CGRect) -> CGFloat {
        if filterView.maxY + contentView.height > UIScreen.main.bounds.size.height {
            return filterView.minY - contentView.height/2
        } else {
            return filterView.maxY + contentView.height/2
        }
    }
    
    fileprivate func positionYFixed() -> CGFloat {
        let fixedHeight: CGFloat = 200.0
        if filterView.maxY + fixedHeight > UIScreen.main.bounds.size.height {
            return filterView.minY - fixedHeight/2
        } else {
            return filterView.maxY + fixedHeight/2
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct OnboardItem: Decodable {
    fileprivate var description: String
    fileprivate var nextButtonTitle: String
    fileprivate var previousButtonTitle: String
    
    public init(description: String, previousButtonTitle: String, nextButtonTitle: String) {
        self.description = description
        self.nextButtonTitle = nextButtonTitle
        self.previousButtonTitle = previousButtonTitle
    }
    
    private enum CodingKeys: String, CodingKey {
        case description, nextButtonTitle, previousButtonTitle
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ProgressiveOnboardView: View {
    
    @ObservedObject public var onboard: ProgressiveOnboard
    
    public init(withProgressiveOnboard: ProgressiveOnboard) {
        self.onboard = withProgressiveOnboard
    }
    
    public var body: some View {
        
        Rectangle()
            .fill(Color.black)
            .opacity(0.8)
            .inverseMask(
                Rectangle()
                    .frame(width: onboard.filterView.width, height: onboard.filterView.height, alignment: .center)
                    .position(x: onboard.filterView.midX, y: onboard.filterView.midY)
                    .animation(.easeInOut(duration: onboard.animateDuration))
            )
        
        HStack {
            
            VStack {
                Text(onboard.description)
                    .padding(10)
                
                HStack {
                    if !onboard.previousButtonTitle.isEmpty {
                        Button(action: {
                            onboard.handlePrevious()
                        }, label: {
                            
                            HStack {
                                Image(systemName: "arrow.left.circle")
                                
                                Text(onboard.previousButtonTitle)
                                        .fontWeight(.semibold)
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                        })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        onboard.handleNext()
                    }, label: {
                        
                        HStack {
                            Image(systemName: "arrow.right.circle")
                            
                            Text(onboard.nextButtonTitle)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(40)
                    })
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(10)
        }
        .position(x: onboard.positionX, y: onboard.positionYFixed())
        .animation(Animation.easeInOut(duration: onboard.animateDuration).delay(0.25))
    }
}

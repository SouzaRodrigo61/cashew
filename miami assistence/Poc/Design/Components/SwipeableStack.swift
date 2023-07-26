//
//  SwipeableStack.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 06/07/23.
//

import SwiftUI

enum ViewPosition {
    case center
    case previous
    case next
}

struct SwipeableStack<WhateverTypeOfData: Hashable, Content>: View where Content: View {

    @State private var dragged = CGSize.zero
    
    private var whateverData: [WhateverTypeOfData] = []
    private let content: (WhateverTypeOfData, ViewPosition, Int) -> Content
    private var jumpTo: WhateverTypeOfData?
    
    init(_ data: [WhateverTypeOfData],
         jumpTo: WhateverTypeOfData? = nil,
         @ViewBuilder content: @escaping (WhateverTypeOfData, ViewPosition, Int) -> Content
    ) {
        self.whateverData = data
        self.content = content
        if let jumpTo {
            self.jumpTo = jumpTo
        }
    }
    
    @State private var dataIndex = 1
    
    var previousExist: Bool {
        return (dataIndex - 1) >= 0
    }
    
    var nextExist: Bool {
        return dataIndex < whateverData.count - 1
    }
    
    var body: some View {
        GeometryReader { geo in
            let frameWidth = geo.size.width
            
            HStack(spacing: 0) {
                
                if previousExist {
                    content(whateverData[dataIndex - 1], .previous, dataIndex) /* Previous*/
                        .frame(width: frameWidth)
                        .offset(x: previousExist ? -frameWidth : nextExist ? 0 : -frameWidth)
                }
                
                content(whateverData[dataIndex], .center, dataIndex) /* Current */
                    .frame(width: frameWidth)
                    .offset(x: previousExist ? -frameWidth : nextExist ? 0 : -frameWidth)
                
                if nextExist {
                    content(whateverData[dataIndex + 1], .next, dataIndex) /* Next */
                        .frame(width: frameWidth)
                        .offset(x: previousExist ? -frameWidth : nextExist ? 0 : -frameWidth)
                }
                
            }
            .onAppear {
                if let jumpTo {
                    if let pos = whateverData.firstIndex(of: jumpTo) {
                        dataIndex = pos
                    }
                }
            }
            .offset(x: dragged.width)
            .gesture(DragGesture()
                .onChanged{ value in
                    dragged.width = value.translation.width
                }
                .onEnded{ value in
                    var indexOffset = 0
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        
                        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                        impactHeavy.impactOccurred()
                        
                        dragged = CGSize.zero
                        
                        if value.predictedEndTranslation.width < -frameWidth / 2 && nextExist{
                            dragged.width = -frameWidth
                            indexOffset = 1 /* Next */
                        }
                        
                        if value.predictedEndTranslation.width > frameWidth / 2 && previousExist{
                            dragged.width = frameWidth
                            indexOffset = -1 /* Previous */
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            dataIndex += indexOffset
                            dragged = CGSize.zero
                        }
                    }
                }
            )
        }
    }
}

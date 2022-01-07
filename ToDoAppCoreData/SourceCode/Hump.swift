//
//  DraggableHump.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 31/12/21.
//

import SwiftUI

/// The hump shape at the top the sheet
///
/// This struct is wrap around the hump shape to give a frame and color
struct Hump: View {
    // MARK: Properties
    var height: Double
    var peakWidth: Double
    var humpHeight: Double
    var color: Color
    
    // MARK: Body
    var body: some View {
        HumpPainter(
            peakWidth, humpHeight)
            .frame(height: height + 60)
            .foregroundColor(color)
    }
}

/// Draws the hump shape
private struct HumpPainter: Shape {
    
    var peakWidth: Double
    var humpHeight: Double
    let baseWidth: Double = 200
    let baseHeight: Double = 60
    
    init( _ pw: Double, _ hh: Double) {
        
        self.peakWidth = pw;
        self.humpHeight = hh;
    }
    
    
    var animatableData: Double {
        get {humpHeight}
        set {humpHeight = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0, y: height))
        path.addQuadCurve(
            to: CGPoint(x: baseHeight, y: height - baseHeight),
            control: CGPoint(x: 0, y: height - baseHeight))
        
        path.addLine(to: CGPoint(x: width/2 - baseWidth/2, y: height - baseHeight))
        
        
        path.addCurve(
            to: CGPoint(x: width/2, y: (height - baseHeight) - humpHeight),
            control1: CGPoint(x:  width/2 - baseWidth/4, y: height - baseHeight),
            control2: CGPoint(x: width/2 - peakWidth/2, y: (height - baseHeight) - humpHeight ))
        
        path.addCurve(
            to: CGPoint(x: width/2 + baseWidth/2, y: height - baseHeight),
            control1: CGPoint(x: width/2 + peakWidth/2, y: (height - baseHeight) - humpHeight),
            control2: CGPoint(x:  width/2 + baseWidth/4, y: height - baseHeight))
        
        path.addLine(to: CGPoint(x: width - baseHeight, y: height - baseHeight))
        
        path.addQuadCurve(
            to: CGPoint(x: width, y: height),
            control: CGPoint(x: width, y: height - baseHeight))
        
        
        
        return path
    }
    
}

// MARK: Previews
struct DraggableHump_Previews: PreviewProvider {
    static var previews: some View {
        Hump(
            height: 160,
            peakWidth: 100,
            humpHeight: 100,
            color: .green
        )
    }
}

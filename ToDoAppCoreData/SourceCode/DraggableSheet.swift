//
//  AddToDoMenu.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 01/01/22.
//

import SwiftUI

/// Draggable sheet at the bottom to add new todo
///
/// Responsible for handling sheet drag animation mainly
struct DraggableSheet: View {
    
    // MARK: Properties
    private let sheetHeight: CGFloat = UIScreen.main.bounds.size.height * 0.7
    private let backgroundColor: Color = Color.black
    private let baseHeight: Double = 60
    
    @State private var humpHeight: Double = 100
    @State private var sheetOffset: Double
    @Binding private var showBlur: Bool
    
    private var sheetVisible: Bool {
        if sheetOffset == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: init
    init(showBlur: Binding<Bool>) {
        self._showBlur = showBlur
        sheetOffset = sheetHeight
    }
    
    // MARK: Body
    var body: some View {
        VStack(spacing: 0.0) {
            Spacer()
            ZStack {
                Hump(
                    height: 100,
                    peakWidth: 100,
                    humpHeight: humpHeight,
                    color: backgroundColor)
                VStack {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                        .opacity(showBlur ? 0 : 1)
                    Rectangle()
                        .frame(width: 60, height: 6)
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .opacity(sheetVisible ? 1 : 0)
                }
            }
            SheetBody()
                .padding(16)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: sheetHeight,
                    alignment: .top)
                .background(backgroundColor)
        }
        .offset(y: sheetOffset + baseHeight)
        .gesture(
            DragGesture()
                .onChanged(onDrag)
                .onEnded(onDragEnd)
        )
        .ignoresSafeArea( edges: .bottom)
    }
    
    // MARK: Functions
    private func onDrag(_ value: DragGesture.Value) {
        if sheetVisible {
            let newValue = humpHeight - (value.translation.height/80)
            if newValue <= 0 && newValue >= -30.0 {
                humpHeight = newValue
            }
            
        } else  {
            let newValue = humpHeight - (value.translation.height/80)
            if newValue >= 100 && newValue <= 180 {
                showBlur = true
                humpHeight = newValue
                sheetOffset = sheetOffset + (value.translation.height/150)
            }
        }
    }
    
    func onDragEnd(_ value: DragGesture.Value) {
        if sheetVisible {
            withAnimation(.spring()) {
                if humpHeight < -25.0 {
                    showBlur = false
                    humpHeight = 100
                    sheetOffset = sheetHeight
                } else {
                    humpHeight = 0
                }
            }
        } else  {
            withAnimation(.spring()) {
                if humpHeight > 175 {
                    humpHeight = 0
                    sheetOffset = 0
                } else {
                    showBlur = false
                    humpHeight = 100
                    sheetOffset = sheetHeight
                }
            }
        }
    }
}

struct AddToDoMenu_Previews: PreviewProvider {
    static var previews: some View {
        DraggableSheet(showBlur: .constant(true))
    }
}




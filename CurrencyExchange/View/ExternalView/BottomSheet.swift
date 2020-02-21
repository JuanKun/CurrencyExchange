//
//  BottomSheet.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 21/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation
import SwiftUI

struct BottomSheet<Content: View> : View {
    
    private let modalHeight: CGFloat = UIScreen.main.bounds.height*(0.4)
    private let modalWidth: CGFloat = UIScreen.main.bounds.width
    private let modalCornerRadius: CGFloat = 10
    private let backgroundOpacity = 0.65
    private let dragIndicatorVerticalPadding: CGFloat = 20
    @State private var offset = CGSize.zero
    @Binding var display: Bool
    @EnvironmentObject var currencyVM: CurrencyViewModel
    var content: () -> Content
    var body: some View {
        ZStack(alignment: .bottom) {
            if display {
                background
                modal
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var background: some View {
        Color.black
            .fillParent()
            .opacity(backgroundOpacity)
            .animation(.spring())
    }
    
    private var modal: some View {
        VStack {
            indicator
            self.content()
        }
        .frame(width: modalWidth, height: modalHeight, alignment: .top)
        .background(Color.white)
        .cornerRadius(modalCornerRadius)
        .offset(y: offset.height)
        .gesture(
            DragGesture()
                .onChanged { value in self.onChangedDragValueGesture(value) }
                .onEnded { value in self.onEndedDragValueGesture(value) }
        )
            .transition(.move(edge: .bottom))
    }
    
    private var indicator: some View {
        DragIndicator()
            .padding(.vertical, dragIndicatorVerticalPadding)
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.modalHeight / 2 else {
            self.offset = CGSize.zero
            return
        }

        withAnimation {
            self.display.toggle()
            self.offset = CGSize.zero
        }
    }
    
    struct DragIndicator: View {
        private let width: CGFloat = 60
        private let height: CGFloat = 6
        private let cornerRadius: CGFloat = 4
        
        var body: some View {
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.4274509804, green: 0.4470588235, blue: 0.4705882353, alpha: 1)))
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
        }
    }
}

//
//  ContentView.swift
//  Better Password
//
//  Created by Dominic Kolbe on 13/01/2022.
//

import SwiftUI
import Foundation
import AlertToast

struct ContentView: View {
  
  @EnvironmentObject var viewModel: ViewModel
  
  // MARK: - Func
  
  func onChange() {
    viewModel.generate()
  }
  
  func onEditingChanged(isEditing: Bool) {
    if (isEditing == false) {
      viewModel.generate()
    }
  }
  
  
  // MARK: - UI
  
  var body: some View {
    
    NavigationView {
      
      VStack {
        
        Form {
          
          // MARK: - SECRET
          
          Section(header: Text("GENERATED_PASSWORD")) {
            Button {
              Utils.Clipboard.set(value: viewModel.password)
              viewModel.showToast.toggle()
            } label: {
              Text(viewModel.password)
                .font(
                  .system(size: 18, weight: .medium, design: .monospaced)
                )
                .lineSpacing(8)
                .foregroundColor(Color(UIColor.label))
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .transition(.opacity)
                .id("SecretText" + viewModel.password)
            }
            
          }
          
          // MARK: - SLIDER
          
          Section(header: Text("LENGTH")) {
            HStack {
              Slider(
                value: $viewModel.totalLength,
                in: viewModel.totalMinLength...viewModel.totalMaxLength,
                step: 1
              ).onChange(of: viewModel.totalLength) { _ in
                onChange()
              }
              Text(String(format: "%.0f", viewModel.totalLength))
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .frame(minWidth: 40, alignment: .trailing)
            }
          }
          
          
          // MARK: - OPTIONS
          
          Section(header: Text("OPTIONS")) {
            
            Stepper(
              value: $viewModel.numbersLength,
              in: 0...(viewModel.totalMaxLength / 2),
              step: 1
            ) {
              HStack {
                Text("MINIMUM_NUMBERS")
                Spacer()
                Text(String(format: "%.0f", viewModel.numbersLength))
                  .padding(.trailing, 8)
              }
            }
            .onChange(of: viewModel.numbersLength) { _ in onChange() }
            
            Stepper(
              value: $viewModel.symbolsLength,
              in: 0...(viewModel.totalMaxLength / 2),
              step: 1
            ) {
              HStack {
                Text("SPECIAL_CHARACTERS")
                Spacer()
                Text(String(format: "%.0f", viewModel.symbolsLength))
                  .padding(.trailing, 8)
              }
            }
            .onChange(of: viewModel.symbolsLength) { _ in onChange() }
            
            Toggle("EXCLUDE_AMBIGUOUS_CHARACTERS", isOn: $viewModel.ambiguousCharactersExclude)
              .onChange(of: viewModel.ambiguousCharactersExclude) { _ in onChange() }
          }
          
          
          // MARK: - BUTTON
          
          Section() {
            Button {
              withAnimation(.easeInOut(duration: 0.2)) {
                onChange()
              }
              
            } label: {
              Text("BUTTON_GENERATE")
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundColor(Color(UIColor.label))
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                .padding(.bottom, 8)
            }
            
          }
          
          // MARK: - END
          
          Section() {
            Button {
              viewModel.reset();
            } label: {
              Text("RESET")
                .frame(maxWidth: .infinity)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.red)
            }
          }
          
          // MARK: - END
          
        }
        
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          HStack {
            Image(systemName: "scribble")
            Text("Pssst.")
              .font(.system(size: 28, weight: .bold, design: .default))
          }
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .toast(isPresenting: $viewModel.showToast){
      AlertToast(
        displayMode: .hud,
        type: .regular,
        title: "Password copied."
      )
    }
    
  }
  
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group{
      ContentView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
        .environment(\.locale, .init(identifier: "en"))
      ContentView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.light)
        .environment(\.locale, .init(identifier: "de"))
    }
  }
}

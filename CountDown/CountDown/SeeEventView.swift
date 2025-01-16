//
//  SeeEventView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct SeeEventView: View {
    
    @ObservedObject var viewModel: CreateNewEventViewModel
    @Binding private var showDelete: Bool
    @EnvironmentObject var tabState: TabState 
    @Environment(\.dismiss) var dismiss


    init(viewModel: CreateNewEventViewModel, showDelete: Binding<Bool> = .constant(false)) {
        self.viewModel = viewModel
        self._showDelete = showDelete
    }

    var body: some View {
        VStack(spacing: 16){
            HStack {
                Text(viewModel.name)
                    .font(.title)
                    .bold()
                Spacer()
            }

            ZStack {
                Circle()
                    .fill(.blue)
                    .opacity(0.35)
                Text(viewModel.emojy)
                    .font(.system(size: 100))
            }

            HStack {
              Text("Style: \(viewModel.emojy)")
                Spacer()
            }
            Divider()


            HStack {
                Text("Date: \(viewModel.date.formatted(date: .complete, time: .complete))")
                Spacer()
            }

            Spacer()
            
            if showDelete {
                Button(action: {
                    print("Delete")
                    dismiss()
                    tabState.selectedTab = 0
                }, label: {
                    Text("Delete")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                })

                Spacer()
            }

            Button(action: {
                dismiss()
                tabState.selectedTab = 0
            }, label: {
                Text("Done")
            })

        }
        .padding()
    }
}

#Preview {
    SeeEventView(viewModel: CreateNewEventViewModel())
}

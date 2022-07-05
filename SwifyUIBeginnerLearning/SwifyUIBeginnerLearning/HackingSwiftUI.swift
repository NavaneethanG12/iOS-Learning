//
//  100DaysOfSwiftUI.swift
//  SwifyUIBeginnerLearning
//
//  Created by navaneeth-pt4855 on 30/06/22.
//

import SwiftUI

struct HackingSwiftUI: View {
    @State private var amount = 0.0
    @FocusState var amtFieldInFocus: Bool
    @State var showAlert: Bool = false
   
    let percentage = [10,20,30,40,50]
    
    @State var selectedPercent = 10
    @State var selectedCount = 2
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select Number of people", selection: $selectedCount){
                        ForEach(1..<100){ count in
                            Text("\(count)").tag(count)
                        }
                    }
                    
                   
                }
                Section(header: Text("Enter the amount")){
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .focused($amtFieldInFocus)
                }
                
                
                Section(header: Text("Select the tip percentage")){
                    Picker("Percentage", selection: $selectedPercent){
                        ForEach(percentage, id: \.self){ value in
                            Text(value, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                Section{
                    Text(amount, format: .currency(code: "USD"))
                    
                    Label("Show Alert", systemImage: "wifi.exclamationmark")
                        .onTapGesture {
                            showAlertInScreen()
                        }

                    Text("")
                        .onTapGesture {
                            
                        }
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
            }.navigationTitle("Forms")
                .navigationBarTitleDisplayMode(.inline)
                .pickerStyle(.automatic)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Text("Done")
                            .onTapGesture {
                                amtFieldInFocus = false

                            }
                    }
                }
                .alert("❌Connectivity Error❌", isPresented: $showAlert, actions: {
                    Button("OK", role: .cancel) {
                        
                    }
                })
                .onChange(of: amount) { newValue in
                    print(amount)
                }
            

        }
    }
    
    func showAlertInScreen(){
        showAlert = true
    }
}

struct _00DaysOfSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        HackingSwiftUI()
    }
}

//
//  ContentView.swift
//  SwiftUISearch
//
//  Created by Ashish Tyagi on 12/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $searchText, isSearching: $isSearching)
                    ForEach((0...20).filter({
                        "\($0)".contains(searchText) || searchText.isEmpty
                    }),id: \.self) { item in
                        HStack {
                            Text("\(item)")
                                .padding()
                            Spacer()
                        }
                        Divider()
                            .background(Color(.systemGray5))

                    }
                }

            }
            .navigationTitle("Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search Your Number", text: $searchText).padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            
            if isSearching {
                
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                }).transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}

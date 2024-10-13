//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/11/24.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    TabView{
                        ForEach(character.images, id: \.self){
                            characterImageURL in
                            AsyncImage(url: characterImageURL) {image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                
                            }placeholder: {
                                ProgressView()
                            }
                        }
 
                    }
                    .tabViewStyle(.page)
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60)
                    
                    VStack (alignment: .leading){
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        Divider()
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        Divider()
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \ .self) {occupation in
                            Text("●\(occupation)")
                                .font(.subheadline)
                            
                        }
                        
                        Divider()
                        
                        Text("Nicknames:")
                        
                        if character.aliases.count > 0 {
                            
                            ForEach(character.aliases, id: \ .self) {alias in
                                Text("●\(alias)")
                                    .font(.subheadline)
                                
                            }
                            
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        // add status - potential spoiler for user
                        
                            DisclosureGroup("Status (spoiler alert!)") {
                                VStack(alignment: .leading){
                                Text(character.status)
                                    .font(.title2)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) {image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                            
                                        }placeholder: {
                                            ProgressView()
                                        }
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 7)
                                        Text("Last words: \"\(death.lastWords)\"")
                                        
                                    }
                                    
                            }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                      }
                            .tint(.primary)// primary matches the mode you are in (dark/light)
                        
                    }
                    .frame(width: geo.size.width/1.25,alignment: .leading)
                    .padding(50)
                }
                .scrollIndicators(.hidden)
                
            }
            
        }
        .ignoresSafeArea()
        
        
    
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}

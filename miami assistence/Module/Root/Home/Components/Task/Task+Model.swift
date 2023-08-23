//
//  Task+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import Foundation

extension Task {
    struct Model: Identifiable, Equatable {
        
        var id = UUID()
        var title: String
        var date: Date
        var duration: TimeInterval
        var isAlert: Bool
        var isRepeted: Bool
        
        var createdAt: Date
        var updatedAt: Date
        
        var tag: [Tag]
        var note: [Note]
        
        struct Note: Identifiable, Equatable {
            var id = UUID()
            var author: String
            var item: [Item]
            
            struct Item: Equatable {
                var position: Int
                var block: Block
                
                enum Block: Equatable {
                    case empty
                    case image(String)
                    case text(Text)
                    case separator(Separator)
                    
                    enum Text: Equatable {
                        case title(String)
                        case subTitle(String)
                        case heading(String)
                        case strong(String)
                        case body(String)
                        case caption(String)
                    }
                    
                    enum Separator: Equatable {
                        case strong
                        case regular
                        case light
                        case dashed
                    }
                }
            }
        }
        struct Tag: Identifiable, Equatable {
            var id = UUID()
            var title: String
        }
    }
    
}

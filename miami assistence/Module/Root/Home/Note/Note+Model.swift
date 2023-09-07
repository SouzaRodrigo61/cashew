//
//  Note+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import Foundation

extension Note {
    struct Model: Identifiable, Equatable {
        var id = UUID()
        var author: String
        var item: [Item]
        
        struct Item: Identifiable, Equatable {
            var id = UUID()
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
}

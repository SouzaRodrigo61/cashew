//
//  Note+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import Foundation

extension Note {
    struct Model: Equatable, Identifiable, Codable {
        var id = UUID()
        var author: String
        var item: [Item]

        struct Item: Equatable, Identifiable, Codable {
            var id = UUID()
            var position: Int
            var block: Block

            enum Block: Equatable, Codable {
                case empty
                case image(String)
                case text(Text)
                case separator(Separator)

                enum Text: Equatable, Codable {
                    case title(String)
                    case subTitle(String)
                    case heading(String)
                    case strong(String)
                    case body(String)
                    case caption(String)
                }

                enum Separator: Equatable, Codable {
                    case strong
                    case regular
                    case light
                    case dashed
                }
            }
        }
    }
}

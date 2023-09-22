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

extension Note.Model {
    static let mock: Self = .init(author: "Rodrigo", item: [
        .init(position: 1, block: .image("abestado")),
        .init(position: 2, block: .separator(.light)),
        .init(position: 3, block: .text(.body("Body"))),
        .init(position: 4, block: .text(.subTitle("subTitle"))),
        .init(position: 5, block: .text(.heading("heading"))),
        .init(position: 6, block: .text(.strong("strong"))),
        .init(position: 7, block: .text(.body("Body"))),
        .init(position: 8, block: .text(.caption("caption"))),
        .init(position: 9, block: .text(.body("Body"))),
        .init(position: 9, block: .empty)
    ])
}


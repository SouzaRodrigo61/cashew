//
//  Note+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import Foundation
import SwiftUI

extension Note {
    struct Model: Equatable, Identifiable, Codable {
        var id = UUID()
        var author: String
        var item: [Item]

        struct Item: Equatable, Identifiable, Codable {
            var id = UUID()
            var position: Int
            var block: Block
            
            struct Block: Equatable, Identifiable, Codable {
                var id = UUID()
                var type: BlockType
                var text: Text?
                var asset: Asset?
                var line: Line?
                var background: Background
                var isMarked: Bool
                var alignment: Alignment
                
                
                enum Line: Equatable, Codable {
                    case strong
                    case regular
                    case light
                    case dashed
                }
                
                struct Asset: Equatable, Identifiable, Codable {
                    var id = UUID()
                    var asset: String
                }
                
                enum Background: Equatable, Codable {
                    case normal
                    case focus
                    case box
                    case card
                }
                
                enum BlockType: Equatable, Codable {
                    case empty
                    case image
                    case text
                    case separator
                }
                
                enum Alignment: Equatable, Codable {
                    case justify
                    case leading
                    case trailing
                    case center
                }
                
                struct Text: Equatable, Identifiable, Codable {
                    var id = UUID()
                    var size: FontSize
                    var fontWeight: FontWeight
                    var text: String
                    
                    enum FontSize: Equatable, Codable {
                        case title
                        case subTitle
                        case heading
                        case body
                        case caption
                    }
                    
                    enum FontWeight: Equatable, Codable {
                        case bold
                        case normal
                        case regular
                        case medium
                        case tiny
                    }
                }
            }
            
        }
    }
}

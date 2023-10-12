//
//  Task+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import Foundation
import SwiftUI
import SwiftData

extension Task {
    typealias Model = SchemaV1.Model
    
    enum SchemaV1: VersionedSchema {
        static var versionIdentifier = Schema.Version(1, 0, 0)
        
        static var models: [any PersistentModel.Type] { [Model.self] }
        
        @Model
        class Model: Identifiable, Codable {
            var id = UUID()
            var title: String = ""
            var date: Date = Date()
            var startedHour: String = ""
            var duration: TimeInterval = 0
            var color: String = ""
            var isAlert: Bool = false
            var isRepeted: Bool = false
            
            var createdAt: Date = Date()
            var updatedAt: Date = Date()
            
//            var tag: [Tag.Model] = []
//            var note: Note.Model
            
            init(title: String, date: Date, startedHour: String, duration: TimeInterval, isAlert: Bool, isRepeted: Bool, createdAt: Date, updatedAt: Date, color: String) {
                self.title = title
                self.date = date
                self.startedHour = startedHour
                self.duration = duration
                self.color = color
                self.isAlert = isAlert
                self.isRepeted = isRepeted
                self.createdAt = createdAt
                self.updatedAt = updatedAt
//                self.tag = tag
//                self.note = note
            }
            
            // Implement the required Decodable initializer
            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                // Decode each property
                self.id = try container.decode(UUID.self, forKey: .id)
                self.title = try container.decode(String.self, forKey: .title)
                self.date = try container.decode(Date.self, forKey: .date)
                self.startedHour = try container.decode(String.self, forKey: .startedHour)
                self.duration = try container.decode(TimeInterval.self, forKey: .duration)
                self.color = try container.decode(String.self, forKey: .color)
                self.isAlert = try container.decode(Bool.self, forKey: .isAlert)
                self.isRepeted = try container.decode(Bool.self, forKey: .isRepeted)
                self.createdAt = try container.decode(Date.self, forKey: .createdAt)
                self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
//                self.tag = try container.decode([Tag.Model].self, forKey: .tag)
//                self.note = try container.decode(Note.Model.self, forKey: .note)
            }
            
            // Implement the required Encodable method
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                // Encode each property
                try container.encode(id, forKey: .id)
                try container.encode(title, forKey: .title)
                try container.encode(date, forKey: .date)
                try container.encode(startedHour, forKey: .startedHour)
                try container.encode(duration, forKey: .duration)
                try container.encode(color, forKey: .color)
                try container.encode(isAlert, forKey: .isAlert)
                try container.encode(isRepeted, forKey: .isRepeted)
                try container.encode(createdAt, forKey: .createdAt)
                try container.encode(updatedAt, forKey: .updatedAt)
//                try container.encode(tag, forKey: .tag)
//                try container.encode(note, forKey: .note)
            }
            
            // Define CodingKeys enum to map properties
            enum CodingKeys: String, CodingKey {
                case id
                case title
                case date
                case startedHour
                case duration
                case color
                case isAlert
                case isRepeted
                case createdAt
                case updatedAt
//                case tag
//                case note
            }
        }
    }
}

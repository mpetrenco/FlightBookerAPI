//
//  Location.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor
import Fluent

final class Location: Model {
    
    /**
     * The name used to represent the PostgreSQL database schema.
     */
    static let schema = "locations"
    
    /**
     * The UUID value used to identify the location row in the database.
     */
    @ID
    var id: UUID?
    
    /**
     * Required empty initializer.
     */
    init() {}
}

extension Location: Content {}

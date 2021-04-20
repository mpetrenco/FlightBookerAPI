//
//  CreateLocations.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Fluent

struct CreateLocations: Migration {
    
    /**
     * The required protocol method responsible for creating the database table.
     */
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("locations")
            .id()
            .field("code", .string, .required)
            .field("airportName", .string, .required)
            .field("city", .string, .required)
            .create()
    }
    
    /**
     * The required protocol method responsible for reverting the changes made in `prepare`.
     * Currently deletes the entire schema.
     */
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("locations").delete()
    }

}

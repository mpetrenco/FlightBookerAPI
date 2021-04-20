//
//  CreateFlights.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Fluent

struct CreateFlights: Migration {
    
    /**
     * The required protocol method responsible for creating the database table.
     */
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("flights")
            .id()
            .field("code", .string, .required)
            .field("price", .double, .required)
            .field("availableSeats", .int, .required)
            .create()
    }
    
    /**
     * The required protocol method responsible for reverting the changes made in `prepare`.
     * Currently deletes the entire schema.
     */
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("flights").delete()
    }
    
}

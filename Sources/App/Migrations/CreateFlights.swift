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
            .field("departureDate", .date, .required)
            .field("arrivalDate", .date, .required)
            .field("isReturn", .bool, .required)
            .field("departureAirport", .uuid, .required, .references("airports", "id"))
            .field("destinationAirport", .uuid, .required, .references("airports", "id"))
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

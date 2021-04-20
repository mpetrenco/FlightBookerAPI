//
//  Flight.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor
import Fluent

final class Flight: Model {
    
    /**
     * The name used to represent the PostgreSQL database schema.
     */
    static let schema = "flights"
    
    /**
     * The UUID value used to identify the flight row in the database.
     */
    @ID
    var id: UUID?
    
    /**
     * The flight code.
     */
    @Field(key: "code")
    var code: String
    
    /**
     * The ticket price.
     */
    @Field(key: "price")
    var price: Double

    /**
     * The number of available flights.
     */
    @Field(key: "availableSeats")
    var availableSeats: Int
    
    /**
     * Required empty initializer.
     */
    init() {}
    
    /**
     * Convenience initializer for setting all the required fields.
     *
     * - parameter id - the UUID used to identify the row in the database.
     * - parameter code - the flight code.
     * - parameter price - the ticket price,
     * - parameter availableSeats - the number of available seats.
     */
    init(id: UUID? = nil,
         code: String,
         price: Double,
         availableSeats: Int) {
        
        self.id = id
        self.code = code
        self.price = price
        self.availableSeats = availableSeats
    }
    
}

extension Flight: Content { }

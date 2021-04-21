//
//  Airport.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor
import Fluent

final class Airport: Model {
    
    /**
     * The name used to represent the PostgreSQL database schema.
     */
    static let schema = "airports"
    
    /**
     * The UUID value used to identify the location row in the database.
     */
    @ID
    var id: UUID?
    
    /**
     * The IATA code used to identify the airport.
     */
    @Field(key: "code")
    var code: String
    
    /**
     * The name of the airport.
     */
    @Field(key: "name")
    var name: String
    
    /**
     * The city name where the airport is located.
     */
    @Field(key: "city")
    var city: String
    
    /**
     * Required empty initializer.
     */
    init() {}
    
    /**
     * Convenience initializer for setting all the required fields.
     *
     * - parameter id - the UUID used to identify the row in the database.
     * - parameter code - the IATA code used to identify the airport.
     * - parameter name - the name of the airport.
     * - parameter city - the city name where the airport is located.
     */
    init(id: UUID? = nil,
         code: String,
         name: String,
         city: String) {
        
        self.id = id
        self.code = code
        self.name = name
        self.city = city
    }
}

extension Airport: Content {}

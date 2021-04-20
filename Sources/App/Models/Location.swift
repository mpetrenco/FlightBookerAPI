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
     * The IATA code used to identify the airport.
     */
    @Field(key: "code")
    var code: String
    
    /**
     * The name of the airport.
     */
    @Field(key: "airportName")
    var airportName: String
    
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
     * - parameter airportName - the name of the airport.
     * - parameter city - the city name where the airport is located.
     */
    init(id: UUID? = nil,
         code: String,
         airportName: String,
         city: String) {
        
        self.id = id
        self.code = code
        self.airportName = airportName
        self.city = city
    }
}

extension Location: Content {}

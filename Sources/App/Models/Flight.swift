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
     * The departure airport location.
     */
    @Parent(key: "departureAirport")
    var departureAirport: Airport
    
    /**
     * The destination airport location.
     */
    @Parent(key: "destinationAirport")
    var destinationAirport: Airport
    
    /**
     * The departure date/time of the flight
     */
    @Field(key: "departureDate")
    var departureDate: Date
    
    /**
     * The arrival date/time of the flight
     */
    @Field(key: "arrivalDate")
    var arrivalDate: Date
    
    /**
     * The ticket price.
     */
    @Field(key: "price")
    var price: Double

    /**
     * A flag to specify if the flight ticket it two-way.
     */
    @Field(key: "isReturn")
    var isReturn: Bool
    
    /**
     * The number of available seats.
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
     * - parameter departureAirportID - the origin aiport location ID.
     * - parameter destinationAirportID - the departure aiport location ID.
     * - parameter departureDate - the departure date.
     * - parameter arrivalDate - the arrival date.
     * - parameter price - the ticket price,
     * - parameter availableSeats - the number of available seats.
     * - parameter isReturn - a flag to specify if the flight ticket it two-way.
     */
    init(id: UUID? = nil,
         code: String,
         departureAirportID: Airport.IDValue,
         destinationAirportID: Airport.IDValue,
         departureDate: Date,
         arrivalDate: Date,
         price: Double,
         availableSeats: Int,
         isReturn: Bool) {
        
        self.id = id
        self.code = code
        self.$departureAirport.id = departureAirportID
        self.$destinationAirport.id = destinationAirportID
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.price = price
        self.availableSeats = availableSeats
        self.isReturn = isReturn
    }
    
}

extension Flight: Content { }

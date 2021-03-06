//
//  FlightsController.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor

struct FlightsController: RouteCollection {
    
    /**
     * A protocol method used to register all available flight-related routes.
     */
    func boot(routes: RoutesBuilder) throws {
        
        let flightsRoute = routes.grouped("api", "flights")
        
        flightsRoute.get(use: getAllHandler)
        flightsRoute.get(":id", use: getHandler)
        flightsRoute.post(use: createHandler)
        flightsRoute.delete(":id", use: deleteHandler)
    }
    
    /**
     * A handler responsible for retrieving all the persisted flights from the database.
     * Resolves to - `GET /api/flights`
     */
    private func getAllHandler(_ req: Request) -> EventLoopFuture<[Flight]> {
        Flight.query(on: req.db)
            .with(\.$departureAirport)
            .with(\.$destinationAirport)
            .all()
    }
    
    /**
     * A handler responsible for retrieving a specific flight, based on the flight ID.
     * Resolves to - `GET /api/flights/{FLIGHT_ID}`
     */
    private func getHandler(_ req: Request) throws -> EventLoopFuture<Flight> {
        
        guard let id = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }
        
        return Flight.query(on: req.db)
            .with(\.$departureAirport)
            .with(\.$destinationAirport)
            .all()
            .map { flights in
                flights.first { $0.id?.uuidString == id }
            }
            .unwrap(or: Abort(.notFound))
    }
    
    /**
     * A handler responsible for adding a new flight to the database
     * Resolves to - `POST /api/flights`
     */
    private func createHandler(_ req: Request) throws -> EventLoopFuture<Flight> {
        let data = try req.content.decode(CreateFlightsData.self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let departureDate = dateFormatter.date(from: data.departureDate) else {
            throw Abort(.badRequest)
        }
        
        guard let arrivalDate = dateFormatter.date(from: data.arrivalDate) else {
            throw Abort(.badRequest)
        }
        
        let flight = Flight(code: data.code,
                            departureAirportID: data.departureAirportID,
                            destinationAirportID: data.destinationAirportID,
                            departureDate: departureDate,
                            arrivalDate: arrivalDate,
                            price: data.price,
                            availableSeats: data.availableSeats,
                            isReturn: data.isReturn)
        
        return flight.save(on: req.db).map { flight }
    }
    
    /**
     * A handler responsible for deleting a flight from the database, based on a specified ID.
     * Resolves to - `DELETE /api/flights/{FLIGHT_ID}`
     */
    private func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Flight.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                acronym.delete(on: req.db)
                    .map { HTTPStatus.noContent }
            }
    }
}

struct CreateFlightsData: Content {
    var code: String
    var departureAirportID: UUID
    var destinationAirportID: UUID
    var departureDate: String
    var arrivalDate: String
    var price: Double
    var isReturn: Bool
    var availableSeats: Int
}

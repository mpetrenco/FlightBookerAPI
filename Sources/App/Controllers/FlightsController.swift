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
        flightsRoute.get(":flightID", use: getHandler)
        flightsRoute.post(use: createHandler)
        flightsRoute.delete(":flightID", use: deleteHandler)
    }
    
    /**
     * A handler responsible for retrieving all the persisted flights from the database.
     * Resolves to - `GET /api/flights`
     */
    private func getAllHandler(_ req: Request) -> EventLoopFuture<[Flight]> {
        Flight.query(on: req.db).all()
    }
    
    /**
     * A handler responsible for retrieving a specific flight, based on the flight ID.
     * Resolves to - `GET /api/flights/{FLIGHT_ID}`
     */
    private func getHandler(_ req: Request) -> EventLoopFuture<Flight> {
        Flight.find(req.parameters.get("flightID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    /**
     * A handler responsible for adding a new flight to the database
     * Resolves to - `POST /api/flights`
     */
    private func createHandler(_ req: Request) throws -> EventLoopFuture<Flight> {
        let flight = try req.content.decode(Flight.self)
        return flight.save(on: req.db).map { flight }
    }
    
    /**
     * A handler responsible for deleting a flight from the database, based on a specified ID.
     * Resolves to - `DELETE /api/flights/{FLIGHT_ID}`
     */
    private func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Flight.find(req.parameters.get("flightID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                acronym.delete(on: req.db)
                    .map { HTTPStatus.noContent }
            }
    }
}

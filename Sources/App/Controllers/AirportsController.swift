//
//  AirportsController.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor

struct AirportsController: RouteCollection {
    
    /**
     * A protocol method used to register all available airport-related routes.
     */
    func boot(routes: RoutesBuilder) throws {
        
        let airportsRoute = routes.grouped("api", "airports")
        
        airportsRoute.get(use: getAllHandler)
        airportsRoute.get(":id", use: getHandler)
        airportsRoute.post(use: createHandler)
        airportsRoute.delete(":id", use: deleteHandler)
    }
    
    /**
     * A handler responsible for retrieving all the persisted airports from the database.
     * Resolves to - `GET /api/airports`
     */
    private func getAllHandler(_ req: Request) -> EventLoopFuture<[Airport]> {
        Airport.query(on: req.db).all()
    }
    
    /**
     * A handler responsible for retrieving a specific airport, based on the location ID.
     * Resolves to - `GET /api/airports/{AIRPORT_ID}`
     */
    private func getHandler(_ req: Request) -> EventLoopFuture<Airport> {
        Airport.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    /**
     * A handler responsible for adding a new airport to the database
     * Resolves to - `POST /api/airports`
     */
    private func createHandler(_ req: Request) throws -> EventLoopFuture<Airport> {
        let airport = try req.content.decode(Airport.self)
        return airport.save(on: req.db).map { airport }
    }
    
    /**
     * A handler responsible for deleting a airport from the database, based on a specified ID.
     * Resolves to - `DELETE /api/airports/{AIRPORT_ID}`
     */
    private func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Airport.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                acronym.delete(on: req.db)
                    .map { HTTPStatus.noContent }
            }
    }
    
}

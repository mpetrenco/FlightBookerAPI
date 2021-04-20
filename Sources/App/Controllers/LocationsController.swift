//
//  LocationsController.swift
//  Created by Mihai Petrenco on 4/20/21.
//

import Vapor

struct LocationsController: RouteCollection {
    
    /**
     * A protocol method used to register all available location-related routes.
     */
    func boot(routes: RoutesBuilder) throws {
        
        let locationsRoute = routes.grouped("api", "locations")
        
        locationsRoute.get(use: getAllHandler)
        locationsRoute.get(":locationID", use: getHandler)
        locationsRoute.post(use: createHandler)
        locationsRoute.delete(":locationID", use: deleteHandler)
    }
    
    /**
     * A handler responsible for retrieving all the persisted locations from the database.
     * Resolves to - `GET /api/locations`
     */
    private func getAllHandler(_ req: Request) -> EventLoopFuture<[Location]> {
        Location.query(on: req.db).all()
    }
    
    /**
     * A handler responsible for retrieving a specific location, based on the location ID.
     * Resolves to - `GET /api/locations/{LOCATION_ID}`
     */
    private func getHandler(_ req: Request) -> EventLoopFuture<Location> {
        Location.find(req.parameters.get("locationID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    /**
     * A handler responsible for adding a new location to the database
     * Resolves to - `POST /api/locations`
     */
    private func createHandler(_ req: Request) throws -> EventLoopFuture<Location> {
        let location = try req.content.decode(Location.self)
        return location.save(on: req.db).map { location }
    }
    
    /**
     * A handler responsible for deleting a location from the database, based on a specified ID.
     * Resolves to - `DELETE /api/locations/{LOCATION_ID}`
     */
    private func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Location.find(req.parameters.get("locationID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                acronym.delete(on: req.db)
                    .map { HTTPStatus.noContent }
            }
    }
    
}

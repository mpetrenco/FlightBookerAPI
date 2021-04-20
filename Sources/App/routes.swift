import Vapor

func routes(_ app: Application) throws {
    let locationsController = LocationsController()
    let flightsController = FlightsController()
    
    try app.register(collection: locationsController)
    try app.register(collection: flightsController)
}

import Vapor

func routes(_ app: Application) throws {
    let flightsController = FlightsController()
    try app.register(collection: flightsController)
}

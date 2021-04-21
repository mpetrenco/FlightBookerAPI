import Vapor

func routes(_ app: Application) throws {
    let airportsController = AirportsController()
    let flightsController = FlightsController()
    
    try app.register(collection: airportsController)
    try app.register(collection: flightsController)
}

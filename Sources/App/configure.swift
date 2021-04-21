import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
    
    /**
     * Configure the database driver to be used.
     */
    if var config = Environment.get("DATABASE_URL")
        .flatMap(URL.init)
        .flatMap(PostgresConfiguration.init) {
        
        config.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(configuration: config), as: .psql)
        
    } else {
        app.databases.use(.postgres(hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                                    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
                                    username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
                                    password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
                                    database: Environment.get("DATABASE_NAME") ?? "vapor_database"), as: .psql)
    }
    
    /**
     * Add the schemas to the database.
     */
    app.migrations.add(CreateAirports())
    app.migrations.add(CreateFlights())
    
    /**
     * Attempt to automatically handle migrations.
     */
    try app.autoMigrate().wait()
    
    /**
     * Register all routes.
     */
    try routes(app)
}

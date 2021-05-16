import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder

    
    let map : NSMutableDictionary = [:]
    
    var getList : [DynamicRoute] = []
    
    getList.append(DynamicRoute(route: "/yolo", staticResponse: "yolo"))
    
    map["GET"] = getList
    
    app.middleware.use(Getez(map))

    // register routes
    try routes(app)
}

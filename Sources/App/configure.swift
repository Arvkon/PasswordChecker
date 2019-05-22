import Leaf
import Vapor
import VaporExt
import Mailgun

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Enable rendering view templates using Leaf
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Enable serving files (like CSS) from the Public folder
    var middlewares = MiddlewareConfig()
    middlewares.use(FileMiddleware.self)
    services.register(middlewares)

    Environment.dotenv()
    let mailgun = Mailgun(apiKey: Environment.get(EnvKeys.mailgunApiKey, ""),
                          domain: Environment.get(EnvKeys.mailgunDomain, ""))
    services.register(mailgun, as: Mailgun.self)
}

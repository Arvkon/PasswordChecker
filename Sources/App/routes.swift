import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {

    router.get { request in
        return try request.view().render("home")
    }

    router.post { request in
        return try request.content.decode(FormInput.self).flatMap(to: View.self) { input in

            if input.password.lowercased() == "strawberries" {
                return try request.view().render("huzzah")
            } else {
                return try request.view().render("incorrect")
            }
        }
    }

    router.post("retry") { request in
        return request.redirect(to: "/")
    }

}

struct FormInput: Content {
    let password: String
}

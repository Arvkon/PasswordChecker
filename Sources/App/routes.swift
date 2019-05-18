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
        return try request.content.decode(FormInput.self).map(to: String.self) { input in

            if input.password.lowercased() == "strawberries" {
                return "Well done! That is the correct password 🎉"
            } else {
                return "Sorry, that's not the correct password 🤡"
            }
        }
    }

}

struct FormInput: Content {
    let password: String
}

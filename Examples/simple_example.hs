import Haspec.JSON
import Haspec.Procedure
import Haspec.Documentation
import qualified Text.Blaze.Html.Renderer.Pretty as R

cookieType = JSObject [JSString, JSNumber]

example :: Procedure JSONType String
example = Procedure {
            name = "getUserToken",
            docstring = "Gets the user token from the server",
            arguments = [("Cookie", cookieType, "isNotSqlInjection")],
            returnType = (JSString, "isUserToken")
          }

main = putStrLn $ R.renderHtml $ getDocumentation $ example

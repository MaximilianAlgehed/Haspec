import Haspec.JSON
import Haspec.Procedure
import Haspec.Documentation
import qualified Text.Blaze.Html.Renderer.Pretty as R

example :: Procedure String String
example = Procedure {
            name = "getUserToken",
            docstring = "Gets the user token from the server",
            arguments = [("Cookie", "JSONString", "isNotSqlInjection")],
            returnType = ("JSONString", "isUserToken")
          }

main = putStrLn $ R.renderHtml $ getDocumentation $ example

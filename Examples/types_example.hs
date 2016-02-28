import Haspec.Types.Types

example = show $ typeToJSON $ Product [Sum [String, Number], Number, String, Array String]

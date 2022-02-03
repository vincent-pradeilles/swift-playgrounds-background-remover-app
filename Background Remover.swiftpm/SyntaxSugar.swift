import Foundation

// Syntax sugar that allows to use `if` and `switch` as expressions
func resultOf<T>(_ code: () -> T) -> T {
    return code()
}

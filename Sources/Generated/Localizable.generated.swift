// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum App {
    /// Chuck Norris Facts
    internal static let name = L10n.tr("Localizable", "App.Name")
  }

  internal enum Common {
    /// Ok
    internal static let ok = L10n.tr("Localizable", "Common.Ok")
    internal enum Error {
      /// Oops! An unexpected error ocurred, please try again.
      internal static let defaultErrorMessage = L10n.tr("Localizable", "Common.Error.DefaultErrorMessage")
      /// Error
      internal static let title = L10n.tr("Localizable", "Common.Error.Title")
    }
    internal enum Suggestion {
      /// uncategorized
      internal static let uncategorized = L10n.tr("Localizable", "Common.Suggestion.Uncategorized")
    }
  }

  internal enum FactsList {
    internal enum Empty {
      /// Oops, we were not able to find any Chuck Norris Facts. :(
      internal static let message = L10n.tr("Localizable", "FactsList.Empty.Message")
    }
    internal enum Title {
      /// Results for: %@
      internal static func results(_ p1: String) -> String {
        return L10n.tr("Localizable", "FactsList.Title.Results", p1)
      }
    }
  }

  internal enum SearchFacts {
    internal enum Section {
      /// Past Searches
      internal static let pastSearches = L10n.tr("Localizable", "SearchFacts.Section.PastSearches")
      /// Suggestions
      internal static let suggestions = L10n.tr("Localizable", "SearchFacts.Section.Suggestions")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

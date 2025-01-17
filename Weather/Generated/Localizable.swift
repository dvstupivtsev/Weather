// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Close
  internal static let close = L10n.tr("Localizable", "Close")

  internal enum Alert {
    /// OK
    internal static let ok = L10n.tr("Localizable", "Alert.Ok")
    internal enum Error {
      /// Error
      internal static let title = L10n.tr("Localizable", "Alert.Error.Title")
    }
  }

  internal enum Cities {
    /// Favorite cities
    internal static let title = L10n.tr("Localizable", "Cities.Title")
  }

  internal enum CitySearch {
    /// Enter city name
    internal static let searchPlaceholder = L10n.tr("Localizable", "CitySearch.SearchPlaceholder")
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

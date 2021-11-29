// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add new Answer
  internal static let add = L10n.tr("myStrings", "add")
  /// Answer
  internal static let answer = L10n.tr("myStrings", "answer")
  /// Cancel
  internal static let cancel = L10n.tr("myStrings", "cancel")
  /// cell
  internal static let cell = L10n.tr("myStrings", "cell")
  /// Delete
  internal static let delete = L10n.tr("myStrings", "delete")
  /// Done
  internal static let done = L10n.tr("myStrings", "done")
  /// Enter your answer
  internal static let enter = L10n.tr("myStrings", "enter")
  /// ERROR
  internal static let error = L10n.tr("myStrings", "error")
  /// HISTORY
  internal static let history = L10n.tr("myStrings", "history")
  /// MAIN
  internal static let main = L10n.tr("myStrings", "main")
  /// SETTINGS
  internal static let settings = L10n.tr("myStrings", "settings")
  /// SOME ANSWER
  internal static let someAnswer = L10n.tr("myStrings", "some_answer")
  /// https://8ball.delegator.com/magic/JSON/question_string
  internal static let url = L10n.tr("myStrings", "url")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

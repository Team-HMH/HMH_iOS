// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DSKitAsset {
  public static let accentColor = DSKitColors(name: "AccentColor")
  public static let challengeBackground = DSKitImages(name: "ChallengeBackground")
  public static let challengeCreate = DSKitImages(name: "ChallengeCreate")
  public static let challengeFail = DSKitImages(name: "ChallengeFail")
  public static let challengeWarn = DSKitImages(name: "ChallengeWarn")
  public static let failRound = DSKitImages(name: "FailRound")
  public static let onboardingFirst = DSKitImages(name: "OnboardingFirst")
  public static let onboardingSecond = DSKitImages(name: "OnboardingSecond")
  public static let onboardingThird = DSKitImages(name: "OnboardingThird")
  public static let redTrash = DSKitImages(name: "RedTrash.")
  public static let shieldView = DSKitImages(name: "ShieldView")
  public static let storyFirst = DSKitImages(name: "StoryFirst")
  public static let storyFourth = DSKitImages(name: "StoryFourth")
  public static let storySecond = DSKitImages(name: "StorySecond")
  public static let storyTextFirst = DSKitImages(name: "StoryTextFirst")
  public static let storyTextFourth = DSKitImages(name: "StoryTextFourth")
  public static let storyTextSecond = DSKitImages(name: "StoryTextSecond")
  public static let storyTextThird = DSKitImages(name: "StoryTextThird")
  public static let storyThird = DSKitImages(name: "StoryThird")
  public static let addAppButton = DSKitImages(name: "addAppButton")
  public static let appleLogo = DSKitImages(name: "appleLogo")
  public static let beforeTake = DSKitImages(name: "beforeTake")
  public static let blackground = DSKitColors(name: "blackground")
  public static let bluePurpleButton = DSKitColors(name: "blue purple_button")
  public static let bluePurpleLine = DSKitColors(name: "blue purple_line")
  public static let bluePurpleOpacity22 = DSKitColors(name: "blue purple_opacity22")
  public static let bluePurpleOpacity70 = DSKitColors(name: "blue purple_opacity70")
  public static let bluePurpleProgress = DSKitColors(name: "blue purple_progress")
  public static let bluePurpleText = DSKitColors(name: "blue purple_text")
  public static let calendarCheck = DSKitImages(name: "calendar-check")
  public static let calendarCheckUnselected = DSKitImages(name: "calendar-checkUnselected")
  public static let chevronLeft = DSKitImages(name: "chevron-left")
  public static let chevronRight = DSKitImages(name: "chevron-right")
  public static let chevronDown = DSKitImages(name: "chevronDown")
  public static let chevronUp = DSKitImages(name: "chevronUp")
  public static let chevrongray = DSKitImages(name: "chevrongray")
  public static let coloredRound = DSKitImages(name: "coloredRound")
  public static let defaultRound = DSKitImages(name: "defaultRound.")
  public static let doneRound = DSKitImages(name: "doneRound")
  public static let doneStar = DSKitImages(name: "doneStar")
  public static let failStar = DSKitImages(name: "failStar")
  public static let gray1 = DSKitColors(name: "gray1")
  public static let gray2 = DSKitColors(name: "gray2")
  public static let gray3 = DSKitColors(name: "gray3")
  public static let gray4 = DSKitColors(name: "gray4")
  public static let gray5 = DSKitColors(name: "gray5")
  public static let gray6 = DSKitColors(name: "gray6")
  public static let gray7 = DSKitColors(name: "gray7")
  public static let gray8 = DSKitColors(name: "gray8")
  public static let home = DSKitImages(name: "home")
  public static let homeUnselected = DSKitImages(name: "homeUnselected")
  public static let kakaoLogo = DSKitImages(name: "kakaoLogo")
  public static let lock = DSKitImages(name: "lock")
  public static let map = DSKitImages(name: "map")
  public static let market = DSKitImages(name: "market")
  public static let minusCircle = DSKitImages(name: "minus-circle")
  public static let navigationPoint = DSKitImages(name: "navigationPoint")
  public static let point = DSKitImages(name: "point")
  public static let pointCount = DSKitImages(name: "pointCount")
  public static let profile = DSKitImages(name: "profile")
  public static let remainEarnPoint = DSKitImages(name: "remainEarnPoint")
  public static let shieldLock = DSKitImages(name: "shieldLock")
  public static let signUpComplete = DSKitImages(name: "signUpComplete")
  public static let successStar = DSKitImages(name: "successStar")
  public static let toast = DSKitColors(name: "toast")
  public static let trash = DSKitImages(name: "trash")
  public static let unlock = DSKitImages(name: "unlock")
  public static let user = DSKitImages(name: "user")
  public static let userUnselected = DSKitImages(name: "userUnselected")
  public static let whiteBtn = DSKitColors(name: "white_btn")
  public static let whiteText = DSKitColors(name: "white_text")
  public static let yelloBtn = DSKitColors(name: "yelloBtn")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DSKitColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DSKitColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: DSKitColors) {
    let bundle = DSKitResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: DSKitColors) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DSKitImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = DSKitResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension DSKitImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the DSKitImages.image property")
  convenience init?(asset: DSKitImages) {
    #if os(iOS) || os(tvOS)
    let bundle = DSKitResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: DSKitImages) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DSKitImages, label: Text) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DSKitImages) {
    let bundle = DSKitResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all

import SwiftUI

public enum SRDesign {
    public enum Spacing {
        public static let xs: CGFloat  = 4
        public static let sm: CGFloat  = 8
        public static let md: CGFloat  = 12
        public static let lg: CGFloat  = 16
        public static let xl: CGFloat  = 24
        public static let xxl: CGFloat = 32
    }

    public enum Radius {
        public static let sm: CGFloat = 6
        public static let md: CGFloat = 10
        public static let lg: CGFloat = 14
    }

    public enum Color {
        public static let errorRed       = SwiftUI.Color.red
        public static let warningOrange  = SwiftUI.Color.orange
        public static let suggestionBlue = SwiftUI.Color.blue
        public static let infoGray       = SwiftUI.Color.secondary
    }
}

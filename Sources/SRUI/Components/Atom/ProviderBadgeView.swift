import SwiftUI
import SRCore

public struct ProviderBadgeView: View {
    public let decision: LLMDecision
    @State private var showPopover = false

    public init(decision: LLMDecision) {
        self.decision = decision
    }

    public var body: some View {
        Button { showPopover.toggle() } label: {
            HStack(spacing: 4) {
                Text(icon)
                Text(label)
                    .font(.caption.weight(.semibold))
            }
            .padding(.horizontal, SRDesign.Spacing.sm)
            .padding(.vertical, SRDesign.Spacing.xs)
            .background(badgeColor.opacity(0.15))
            .foregroundStyle(badgeColor)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            VStack(alignment: .leading, spacing: SRDesign.Spacing.sm) {
                Text("Routing Decision")
                    .font(.headline)
                Text(reason)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(SRDesign.Spacing.md)
            .frame(minWidth: 200, maxWidth: 280)
        }
    }

    private var icon: String {
        switch decision {
        case .useLocal:          return "⚡"
        case .useCloud, .askUser: return "☁️"
        }
    }

    private var label: String {
        switch decision {
        case .useLocal:           return "Local"
        case .useCloud, .askUser: return "Cloud"
        }
    }

    private var badgeColor: Color {
        switch decision {
        case .useLocal:           return .yellow
        case .useCloud, .askUser: return .blue
        }
    }

    private var reason: String {
        switch decision {
        case .useLocal(let r), .useCloud(let r), .askUser(let r): return r
        }
    }
}

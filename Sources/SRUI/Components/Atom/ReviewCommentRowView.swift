import SwiftUI
import SRCore

public struct ReviewCommentRowView: View {
    public let comment: ReviewComment
    @State private var isExpanded = false

    public init(comment: ReviewComment) {
        self.comment = comment
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header row — always visible
            Button {
                withAnimation(.easeInOut(duration: 0.2)) { isExpanded.toggle() }
            } label: {
                HStack(spacing: SRDesign.Spacing.sm) {
                    Circle()
                        .fill(severityColor)
                        .frame(width: 8, height: 8)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(comment.title)
                            .font(.callout.weight(.semibold))
                            .foregroundStyle(.primary)
                            .lineLimit(isExpanded ? nil : 1)

                        if let line = comment.line {
                            Text("Line \(line)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, SRDesign.Spacing.sm)
                .padding(.horizontal, SRDesign.Spacing.md)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // Expanded body
            if isExpanded {
                VStack(alignment: .leading, spacing: SRDesign.Spacing.sm) {
                    Text(comment.body)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    if let suggestion = comment.suggestion {
                        Text(suggestion)
                            .font(.system(.callout, design: .monospaced))
                            .padding(SRDesign.Spacing.sm)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.secondary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: SRDesign.Radius.sm))
                    }
                }
                .padding(.horizontal, SRDesign.Spacing.md)
                .padding(.bottom, SRDesign.Spacing.md)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: SRDesign.Radius.md)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: SRDesign.Radius.md)
                .strokeBorder(Color.secondary.opacity(0.15), lineWidth: 1)
        )
    }

    private var severityColor: Color {
        switch comment.severity {
        case .error:      return SRDesign.Color.errorRed
        case .warning:    return SRDesign.Color.warningOrange
        case .suggestion: return SRDesign.Color.suggestionBlue
        case .info:       return SRDesign.Color.infoGray
        }
    }
}

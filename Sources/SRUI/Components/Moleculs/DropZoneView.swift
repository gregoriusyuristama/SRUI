import SwiftUI
import UniformTypeIdentifiers
import AppKit

public struct DropZoneView: View {
    public let onFileDropped: (URL) -> Void

    @State private var isTargeted = false

    private static let supportedUTTypes: [UTType] = [
        UTType(filenameExtension: "swift") ?? .plainText,
        UTType(filenameExtension: "m")     ?? .plainText,
        UTType(filenameExtension: "h")     ?? .plainText,
    ]

    public init(onFileDropped: @escaping (URL) -> Void) {
        self.onFileDropped = onFileDropped
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: SRDesign.Radius.lg)
                .strokeBorder(
                    isTargeted ? Color.accentColor : Color.secondary.opacity(0.4),
                    style: StrokeStyle(lineWidth: 2, dash: [8])
                )
                .background(
                    RoundedRectangle(cornerRadius: SRDesign.Radius.lg)
                        .fill(isTargeted ? Color.accentColor.opacity(0.08) : Color.secondary.opacity(0.05))
                )

            VStack(spacing: SRDesign.Spacing.md) {
                Image(systemName: "arrow.down.doc")
                    .font(.system(size: 40))
                    .foregroundStyle(isTargeted ? AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))

                Text("Drop a .swift, .m, or .h file")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text("or")
                    .font(.caption)
                    .foregroundStyle(.tertiary)

                Button("Browse…") { openPanel() }
                    .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDrop(of: [UTType.fileURL], isTargeted: $isTargeted, perform: handleDrop)
    }

    private func handleDrop(_ providers: [NSItemProvider]) -> Bool {
        guard let provider = providers.first else { return false }
        provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
            guard let data = item as? Data,
                  let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
            let ext = url.pathExtension.lowercased()
            guard ["swift", "m", "h"].contains(ext) else { return }
            DispatchQueue.main.async { onFileDropped(url) }
        }
        return true
    }

    private func openPanel() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = Self.supportedUTTypes
        if panel.runModal() == .OK, let url = panel.url {
            onFileDropped(url)
        }
    }
}

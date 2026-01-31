import KeyboardShortcuts
import SwiftUI

struct PreviewItemView: View {
  weak var item: HistoryItemDecorator?

  var body: some View {
    if let item = item {
      VStack(alignment: .leading, spacing: 0) {
        if let image = item.previewImage {
          Image(nsImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 5))
        } else {
          ScrollView {
            WrappingTextView {
              Text(item.text)
                .font(.body)
            }
          }
        }

        Divider()
          .padding(.vertical)

        if let application = item.application {
          HStack(spacing: 3) {
            Text(NSLocalizedString("application", comment: ""))
            Image(nsImage: item.applicationImage.nsImage)
              .resizable()
              .frame(width: 11, height: 11)
            Text(application)
          }
        }

        HStack(spacing: 3) {
          Text(NSLocalizedString("first_copy_time", comment: ""))
          Text(item.item.firstCopiedAt, style: .date)
          Text(item.item.firstCopiedAt, style: .time)
        }

        HStack(spacing: 3) {
          Text(NSLocalizedString("last_copy_time", comment: ""))
          Text(item.item.lastCopiedAt, style: .date)
          Text(item.item.lastCopiedAt, style: .time)
        }

        HStack(spacing: 3) {
          Text(NSLocalizedString("number_of_copies", comment: ""))
          Text(String(item.item.numberOfCopies))
        }
        .padding(.bottom)

        if let pinKey = KeyboardShortcuts.Shortcut(name: .pin) {
          Text(
            NSLocalizedString("pin_key", comment: "")
              .replacingOccurrences(of: "{pinKey}", with: pinKey.description)
          )
        }

        if let deleteKey = KeyboardShortcuts.Shortcut(name: .delete) {
          Text(
            NSLocalizedString("delete_key", comment: "")
              .replacingOccurrences(of: "{deleteKey}", with: deleteKey.description)
          )
        }

        if item.item.image != nil, let copyImageTextKey = KeyboardShortcuts.Shortcut(name: .copyImageText) {
          Text(
            NSLocalizedString("copy_image_text_key", comment: "")
              .replacingOccurrences(of: "{copyImageTextKey}", with: copyImageTextKey.description)
          )
        }
      }
      .controlSize(.small)
      .padding()
    }
  }
}

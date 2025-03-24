#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Mail\n\n"

# General Settings
execute "defaults write com.apple.mail MinimumHTMLFontSize -int 14" \
    "Set minimum font size for HTML messages"

execute "defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false" \
    "Copy email addresses without names"

execute "defaults write com.apple.mail NSUserKeyEquivalents -dict-add 'Send' '@\\U21a9'" \
    "Set keyboard shortcut for Send to Command+Return"

execute "defaults write com.apple.mail DisableInlineAttachmentViewing -bool true" \
    "Disable inline attachment viewing"

execute "defaults write com.apple.mail EnableBundles -bool true" \
    "Enable Mail plugins"

# Viewing Settings
execute "defaults write com.apple.mail DraftsViewerAttributes -dict-add 'DisplayInThreadedMode' -string 'yes'" \
    "Enable threaded mode for drafts"

execute "defaults write com.apple.mail DraftsViewerAttributes -dict-add 'SortedAscending' -string 'yes'" \
    "Sort drafts in ascending order"

execute "defaults write com.apple.mail DraftsViewerAttributes -dict-add 'SortOrder' -string 'received-date'" \
    "Sort drafts by received date"

execute "defaults write com.apple.mail ThreadingDefault -int 1" \
    "Enable threaded mode by default"

execute "defaults write com.apple.mail ThreadViewerAttributes -dict-add 'SortOrder' -string 'received-date'" \
    "Sort threads by received date"

# Composing Settings
execute "defaults write com.apple.mail NSUserKeyEquivalents -dict-add 'Archive' '@$a'" \
    "Set keyboard shortcut for Archive to Command+Option+A"

execute "defaults write com.apple.mail SmartReplyQuoting -bool true" \
    "Enable smart reply quoting"

execute "defaults write com.apple.mail AlwaysShowTo -bool true" \
    "Always show To field"

execute "defaults write com.apple.mail AlwaysShowCc -bool false" \
    "Hide Cc field by default"

execute "defaults write com.apple.mail AlwaysShowBcc -bool false" \
    "Hide Bcc field by default"

execute "defaults write com.apple.mail ComposeFontName -string 'Helvetica'" \
    "Set default compose font to Helvetica"

execute "defaults write com.apple.mail ComposeFontSize -int 14" \
    "Set default compose font size to 14"

# Reading Settings
execute "defaults write com.apple.mail PreferPlainText -bool true" \
    "Prefer plain text over rich text"

execute "defaults write com.apple.mail LoadRemoteContent -bool false" \
    "Don't load remote content in messages"

execute "defaults write com.apple.mail DisplayExternalImages -bool false" \
    "Don't display remote images"

execute "defaults write com.apple.mail AutoFetch -bool true" \
    "Automatically fetch new messages"

execute "defaults write com.apple.mail PollTime -int 5" \
    "Check for new messages every 5 minutes"

# Privacy Settings
execute "defaults write com.apple.mail-shared DisableURLLoading -bool true" \
    "Disable loading of remote URLs"

execute "defaults write com.apple.mail DisplayPreviewPane -bool false" \
    "Disable preview pane"

execute "defaults write com.apple.mail SuppressRemoteContentWarning -bool false" \
    "Show warning about remote content"

# Junk Mail Settings
execute "defaults write com.apple.mail JunkMailBehavior -int 2" \
    "Move junk mail to Junk folder"

execute "defaults write com.apple.mail UseJunkAssassin -bool true" \
    "Enable junk mail filtering"

execute "defaults write com.apple.mail SpamAssassinEnabled -bool true" \
    "Enable SpamAssassin"

execute "defaults write com.apple.mail SpamAssassinRequiredHits -int 5" \
    "Set SpamAssassin required hits to 5"

# Attachments Settings
execute "defaults write com.apple.mail AttachmentViewerAttributes -dict-add 'ShowAttachmentIcon' -bool true" \
    "Show attachment icons"

execute "defaults write com.apple.mail AttachmentViewerAttributes -dict-add 'ShowAttachmentSize' -bool true" \
    "Show attachment sizes"

execute "defaults write com.apple.mail AttachmentViewerAttributes -dict-add 'ShowAttachmentType' -bool true" \
    "Show attachment types"

# Notifications
execute "defaults write com.apple.mail NewMessageSound -string 'Submarine'" \
    "Set new message sound to Submarine"

execute "defaults write com.apple.mail MailUserNotificationScope -int 2" \
    "Show notifications for VIP senders only"

# Signatures
execute "defaults write com.apple.mail SignaturePlacement -int 1" \
    "Place signatures above quoted text"

execute "defaults write com.apple.mail SignatureEnabled -bool true" \
    "Enable signatures"

# Rules
execute "defaults write com.apple.mail RulesEnabled -bool true" \
    "Enable mail rules"

execute "defaults write com.apple.mail RulesAreEnabled -bool true" \
    "Enable rules processing"

# Search
execute "defaults write com.apple.mail IndexingEnabled -bool true" \
    "Enable Spotlight indexing"

execute "defaults write com.apple.mail EnableThreadedSearches -bool true" \
    "Enable threaded searches"

# Account Settings
execute "defaults write com.apple.mail DownloadAttachments -bool true" \
    "Download attachments automatically"

execute "defaults write com.apple.mail DownloadCompleteMessagesEnabled -bool true" \
    "Download complete messages"

execute "defaults write com.apple.mail PreferImap -bool true" \
    "Prefer IMAP over POP"

# Restart Mail
execute "killall Mail" \
    "Restart Mail"

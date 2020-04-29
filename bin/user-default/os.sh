#!/bin/bash -e

if [ "$(uname)" != "Darwin" ];then
  exit 0
fi

# Dock

# Automatically hide or show the Dock （Dock を自動的に隠す）
defaults write com.apple.dock autohide -bool true
# Wipe all app icons from the Dock （Dock に標準で入っている全てのアプリを消す、Finder とごみ箱は消えない）
defaults write com.apple.dock persistent-apps -array
# Set the icon size （アイコンサイズの設定）
defaults write com.apple.dock tilesize -int 55
# Magnificate the Dock （Dock の拡大機能を入にする）
defaults write com.apple.dock magnification -bool true

# Finder

# Automatically open a new Finder window when a volume is mounted
# マウントされたディスクがあったら、自動的に新しいウィンドウを開く
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Set `${HOME}` as the default location for new Finder windows
# 新しいウィンドウでデフォルトでホームフォルダを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Show Status bar in Finder （ステータスバーを表示）
defaults write com.apple.finder ShowStatusBar -bool true
# Show Path bar in Finder （パスバーを表示）
defaults write com.apple.finder ShowPathbar -bool true
# Show Tab bar in Finder （タブバーを表示）
defaults write com.apple.finder ShowTabView -bool true
# Show the ~/Library directory （ライブラリディレクトリを表示、デフォルトは非表示）
chflags nohidden ~/Library
# Show the hidden files （不可視ファイルを表示）
defaults write com.apple.finder AppleShowAllFiles YES
# ネットワークストレージに .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# USBストレージに .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# 全ての拡張子のファイルを表示する
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder のタイトルバーにフルパスを表示する
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# 検索時にデフォルトでカレントディレクトリを検索する
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# 拡張子変更時の警告を無効化する
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# クイックルックでテキストを選択可能にする
defaults write com.apple.finder QLEnableTextSelection -bool true
# Finder を終了させる項目を追加する
defaults write com.apple.Finder QuitMenuItem -bool true

# Safari

# Enable the `Develop` menu and the `Web Inspector` （開発メニューを表示）
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# Enable `Debug` menu （メニュー → デバッグを表示）
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# Show the full URL in the address bar (note: this will still hide the scheme)
# アドレスバーに完全なURLを表示
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Add a context menu item for showing the `Web Inspector` in web views
# コンテキストメニューにWebインスペクタを追加
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# Show Safari's Status Bar （ステータスバーを表示）
defaults write com.apple.Safari ShowStatusBar -bool true
# Don't remember passwords （パスワードを自動入力・記録しない）
defaults write com.apple.Safari AutoFillPasswords -bool false
# 検索クエリを Apple へ送信しない
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# 検索クエリを Apple へ送信しない 
defaults write com.apple.Safari UniversalSearchEnabled -bool false
# アドレスバーに完全な URL を表示する
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Others

# 未確認のアプリケーションを実行する際のダイアログを無効にする
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Show the battery percentage from the menu bar （バッテリーのパーセントを表示する）
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# 日付と時刻のフォーマット（24時間表示、秒表示あり、日付・曜日を表示）
defaults write com.apple.menuextra.clock DateFormat -string "M\u6708d\u65e5(EEE) H:mm:ss"
# Expand save panel by default (無; 保存ダイアログのデフォルト表示スタイル -> true (常に詳細な情報を開いて表示))
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Save to disk (not to iCloud) by default (icloud 対応アプリでのファイル保存時のデフォルトを icloud にする -> false)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# ファンクションキー単独押しでF1,F2,.. , Fnと合わせて特殊機能を使用
defaults write -g "com.apple.keyboard.fnState" 1      

# Menu bar

# 音量アイコンをMenuBarに表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" 1
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
# BluetoothアイコンをMenuBarに表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" 1
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

echo "Finished. Please reboot this Computer."

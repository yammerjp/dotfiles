# スクリプトのパス（ホームディレクトリ取得）
user = ENV['USER']
home = "/Users/#{user}"
script_path = "#{home}/bin/cleanup_desktop.sh"
plist_path = "#{home}/Library/LaunchAgents/com.#{user}.cleanupdesktop.plist"

# スクリプト本体
directory "#{home}/bin"

file script_path do
  owner user
  mode "755"
  content <<~EOS
    #!/bin/bash
    find "#{home}/Desktop" -type f -mtime +7 -delete
  EOS
end

# launchd plist
file plist_path do
  owner user
  mode "644"
  content <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.#{user}.cleanupdesktop</string>

        <key>ProgramArguments</key>
        <array>
          <string>#{script_path}</string>
        </array>

        <key>StartCalendarInterval</key>
        <dict>
          <key>Hour</key>
          <integer>3</integer>
          <key>Minute</key>
          <integer>0</integer>
        </dict>

        <key>RunAtLoad</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>/tmp/cleanup_desktop.err</string>
        <key>StandardOutPath</key>
        <string>/tmp/cleanup_desktop.out</string>
      </dict>
    </plist>
  XML
end

# launchctl load（初回読み込みだけ）
execute "launchctl load #{plist_path}" do
  not_if "launchctl list | grep com.#{user}.cleanupdesktop"
end

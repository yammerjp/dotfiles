home = ENV['HOME']
script_path = "#{home}/bin/cleanup_tmp_dirs.sh"
launch_agent_path = "#{home}/Library/LaunchAgents/local.cleanup_tmp_dirs.plist"

directory "#{home}/bin"

file script_path do
  content <<~SH
    #!/bin/bash

    TMPDIR="$HOME/tmp"
    limit_date=$(date -v-7d +%Y%m%d)

    for dir in "$TMPDIR"/*; do
      [ -d "$dir" ] || continue
      dirname=$(basename "$dir")

      if [[ "$dirname" =~ ^([0-9]{8})-[a-zA-Z0-9]+$ ]]; then
        dir_date="${BASH_REMATCH[1]}"
        if [[ "$dir_date" -lt "$limit_date" ]]; then
          echo "削除中: $dir"
          rm -rf "$dir"
        fi
      fi
    done
  SH
  mode "755"
end

directory File.dirname(launch_agent_path)

file launch_agent_path do
  content <<~PLIST
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>local.cleanup_tmp_dirs</string>

      <key>ProgramArguments</key>
      <array>
        <string>#{script_path}</string>
      </array>

      <key>StartCalendarInterval</key>
      <dict>
        <key>Hour</key>
        <integer>10</integer>
        <key>Minute</key>
        <integer>0</integer>
      </dict>

      <key>StandardOutPath</key>
      <string>#{home}/Library/Logs/cleanup_tmp_dirs.log</string>
      <key>StandardErrorPath</key>
      <string>#{home}/Library/Logs/cleanup_tmp_dirs.err</string>
    </dict>
    </plist>
  PLIST
  mode "644"
end

# launchctl に読み込ませる
execute "load launch agent" do
  command "launchctl unload #{launch_agent_path} || true; launchctl load #{launch_agent_path}"
end

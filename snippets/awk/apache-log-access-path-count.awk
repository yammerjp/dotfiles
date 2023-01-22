{
  counts[$7]++
}
END{
  for(path in counts) {
    printf "%5d %s\n", counts[path], path
  }
}
# $ curl -sL "https://raw.githubusercontent.com/oreilly-japan/mastering-linux-shell-scripting-2e-ja/main/ch12/access.log" | awk '{counts[$7]++} END{for(path in counts){printf "%5d %s\n", counts[path], path}}' | sort -r |head
# 3468 /favicon.ico
# 2330 /wp/wp-content/themes/twentytwelve/style.css?ver=3.9.1
# 2265 /wp/wp-content/themes/twentytwelve/js/navigation.js?ver=20140711
# 2199 /wp/wp-includes/js/jquery/jquery.js?ver=1.11.0
# 2187 /wp/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.2.1
# 2024 /wp/wp-content/uploads/2014/05/cropped-wp3.png
#  709 /wp/?feed=rss2
#  507 /
#  334 /wp/?p=2407
#  329 /stylesheets/screen.css

# $ curl -sL "https://raw.githubusercontent.com/oreilly-japan/mastering-linux-shell-scripting-2e-ja/main/ch12/access.log" | awk '{print $7}' | sort | uniq -c | sort -r | head

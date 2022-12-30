function green(s) {
  printf "\033[1;32m" s "\033[0m\n"
}

BEGIN {
  FS=":"
  green("                   Name: UID:               Shell:")
}


!/^#/{
  printf "%24s %4d %20s\n", $1, $3, $7
}

# need the input of /etc/passwd
#
# awk -f ~/snippets/awk/etcpasswd.awk /etc/passwd

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function proxy
  if test "$argv[1]" = "on"
    if test "$argv[2]" = ""
      echo "No port provided"
      return 2
    end
    # proxy offered by local shadowsocks
    export http_proxy="http://127.0.0.1:$argv[2]"
    export https_proxy="http://127.0.0.1:$argv[2]"
  else if test "$argv[1]" = "off"
    set -e http_proxy  # set --erase
    set -e https_proxy
  else if test "$argv[1]" != ""
    echo "Usage: 
        proxy          - view current proxy
        proxy on PORT  - turn on proxy at localhost:PORT
        proxy off      - turn off proxy"
    return 1
  end
  echo "Current: http_proxy=$http_proxy https_proxy=$https_proxy"
end

set -gx EDITOR nvim

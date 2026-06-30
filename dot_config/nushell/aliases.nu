alias cd = z
alias cat = bat
alias dc = docker compose
alias nu-mkdir = mkdir
alias mkdir = ^mkdir
alias p = cd ~/Documents/Projekty
alias o = open
alias open = ^open
# alias ls = eza

# Camera
alias fakecam = scrcpy --video-source=camera --camera-id=0 --no-audio-playback --select-tcpip --camera-fps=60
alias cam = scrcpy --video-source=camera --no-audio --camera-size=1920x1080 --v4l2-sink=/dev/video0 --no-playback --camera-fps=60 --no-window

def canoncam [] {
    sudo pkill -9 gphoto
    gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -af "hqdn3d" -pix_fmt yuv420p -threads 0 -s:v 1920x1080 -f v4l2 /dev/video0
}

def title [...args: string] {
    ^kitty @ set-tab-title ($args | str join " ")
}

def fgc [repo: string, ...args: string] {
    ^git clone $"ssh://git@git.agin.rocks/($repo).git" ...$args
}

def fgset [repo: string, ...args: string] {
    ^git remote set-url origin $"ssh://git@git.agin.rocks/($repo).git" ...$args
}

def fgadd [repo: string, ...args: string] {
    ^git remote add origin $"ssh://git@git.agin.rocks/($repo).git" ...$args
}

def ghc [repo: string, ...args: string] {
    ^git clone $"ssh://git@github.com/($repo).git" ...$args
}

def esc [repo: string, ...args: string] {
    ^git clone $"ssh://git@git.e-science.pl/($repo).git" ...$args
}

def kwc [repo: string, ...args: string] {
    ^git clone $"ssh://git@rizznode:7505/($repo).git" ...$args
}

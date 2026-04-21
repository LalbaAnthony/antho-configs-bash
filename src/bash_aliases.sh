# ! MIND RELOAD BASH AFTER ANY CHANGE TO THIS FILE, OTHERWISE CHANGES WON'T BE TAKEN INTO ACCOUNT. USE `reload` ALIAS OR RUN `source ~/.bashrc && bash`

# ===========================
# Theme
# ===========================

RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
BLUE='\[\e[34m\]'
MAGENTA='\[\e[35m\]'
CYAN='\[\e[36m\]'
WHITE='\[\e[97m\]'
RESET='\[\e[0m\]'

export PS1="\$([ \"\$(id -u)\" = \"0\" ] && echo \"${RED}\" || echo \"${CYAN}\")\u${WHITE}@${GREEN}\h${RESET}:${YELLOW}\w${RESET}# "

# ===========================
# CONFIG
# ===========================

# History
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTIGNORE="&:ls:cd:cd -:pwd:exit:clear"
shopt -s histappend

# ===========================
# ALIASES
# ===========================

# Commands
alias cls='clear'
alias please='sudo'
alias plz='sudo'
alias pleasefuck='sudo $(fc -ln -1)' # Repeat last command with sudo, works even if last command had arguments
alias plzfuck='sudo $(fc -ln -1)'
alias fuck='fc -e nano' # Edit last command in nano
alias again='fc -s' # Repeat last command
alias h='history | tail -n 30'
alias hfreq='history | awk "{print \$2}" | sort | uniq -c | sort -nr | head -n 20' # Most frequently used commands

# Files
alias ll='ls -lah --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias f='find . -name' # Search for a file in the current directory

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias www='cd /var/www'
alias html='cd /var/www/html'

# System
alias syslog='tail -n 1000 /var/log/syslog'
alias bashrc='nano ~/.bashrc'
alias bash_aliases='nano ~/.bash_aliases'
alias bash_commands='nano ~/.bash_commands'
alias reload='source ~/.bashrc && bash'
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && echo "System updated"'

# Disk
alias du20='du -ah . | sort -rh | head -n 20' # Show top 20 largest files/folders in current directory
alias watchspace='watch -n5 "df -hT | grep -E \"Filesystem|/dev/\""' # Monitor disk space every 5 seconds

# Network
alias speed='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias ipl='hostname -I' # Get local IP address
alias ipp='curl ifconfig.me && echo' # Get public IP address
alias ports='netstat -tulanp' # List all listening ports
alias killport='f(){ sudo lsof -t -i:$1 | xargs sudo kill -9; }; f'
alias randpass='openssl rand -base64 20'
alias nettop='sudo netstat -tulpen | sort -k3' # Show open TCP connections sorted
alias dnscheck='for d in 1.1.1.1 8.8.8.8 9.9.9.9; do ping -c2 $d; done' # Ping all DNS providers (Cloudflare, Google, Quad9)

# Docker
alias dps='docker ps'
alias dpa='docker ps -a'
alias drm='docker rm -f'
alias dim='docker images'
alias dlog='docker logs -f'
alias dclean='docker system prune -af --volumes'
alias dexec='f(){ docker exec -it "$1" bash; }; f' # Usage: dexec <container_id>
alias drestart='docker restart $(docker ps -q)' # Restart all running containers

# Git
alias gs='git status -sb'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpo='git push origin'
alias gpl='git pull'
alias gf='git fetch'
alias gplo='git pull origin'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gds='git diff --shortstat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbd='git branch -d'
alias gundo='git reset --soft HEAD~1'
alias gclean='git reset --hard && git clean -fd'
alias gtags='git tag -l --sort=-creatordate | head -n 10'
alias gpf='git push --force-with-lease'

# Apache
alias a2log='tail -f /var/log/apache2/error.log'
alias a2c='sudo apache2ctl configtest'
alias a2s='sudo systemctl status apache2'
alias a2r='sudo systemctl reload apache2'
alias a2rr='sudo systemctl restart apache2 || sudo apache2ctl configtest'
alias a2sa='cd /etc/apache2/sites-available'
alias a2se='cd /etc/apache2/sites-enabled'

# PHP
alias phpswitch='sudo update-alternatives --config php'
alias phplist='sudo update-alternatives --list php'
alias php56='sudo update-alternatives --set php /usr/bin/php5.6 && sudo systemctl restart apache2'
alias php70='sudo update-alternatives --set php /usr/bin/php7.0 && sudo systemctl restart apache2'
alias php74='sudo update-alternatives --set php /usr/bin/php7.4 && sudo systemctl restart apache2'
alias php81='sudo update-alternatives --set php /usr/bin/php8.1 && sudo systemctl restart apache2'
alias php82='sudo update-alternatives --set php /usr/bin/php8.2 && sudo systemctl restart apache2'
alias php83='sudo update-alternatives --set php /usr/bin/php8.3 && sudo systemctl restart apache2'
alias php84='sudo update-alternatives --set php /usr/bin/php8.4 && sudo systemctl restart apache2'
alias phpsetup='rm -rf vendor composer.lock && composer install'

# Wordpress
alias wpclisetup='cd ~ && rm -f wp-cli.phar && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar'
# alias wp='~/wp-cli.phar' # ? If you want to use wp from anywhere, uncomment this line and add ~/ to your $PATH
alias wplist='wp plugin list --field=name' # List all plugin slugs
alias wpclear='wp cache flush && wp transient delete --all && sudo systemctl reload apache2' # Clear all cache layers
alias wpexport='wp db export backup_wp_$(date +%F_%H-%M-%S).sql' # Export DB to timestamped file
alias wptestdb='sudo -u www-data php -r '\''require "wp-config.php"; $m = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME); echo $m->connect_error ? "Error: " . $m->connect_error : "Success!\n";'\'''
alias wptesturl='sudo -u www-data php -r '\''require "wp-load.php"; echo get_option("siteurl")."\n"; echo get_option("home")."\n";'\'''

# Laravel
alias art='php artisan'
alias artperm='sudo chown -R www-data:www-data public storage bootstrap/cache && sudo chmod -R 775 public storage bootstrap/cache'
alias artcache='art cache:clear && art config:clear && art view:clear && art route:clear && art optimize:clear&& art config:cache'
alias artsetup='phpsetup && artperm && artcache && art storage:link && art migrate:fresh'
alias artserve='art serve --host=0.0.0.0 --port=8000'

# Python
alias psetup='rm -rf venv && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt'

# Node
alias nr='npm run'
alias nrb='npm run build'
alias nrd='npm run dev'
alias nrt='npm run test'
alias nstart='npm start'
alias nsetup='rm -rf node_modules && rm -rf .vite .cache && rm -rf package-lock.json && npm i'
alias yr='yarn run'
alias yrb='yarn run build'
alias yrd='yarn run dev'
alias yrt='yarn run test'
alias ystart='yarn start'
alias ysetup='rm -rf node_modules && rm -rf .vite .cache && rm -rf yarn.lock && yarn install'

# Quasar
alias qd='quasar dev'
alias qb='quasar build'

# ===========================
# COMMANDS
# ===========================

webperms() {
    local TARGET=$1
    local OWNER=${2:-www-data}

    if [ -z "$TARGET" ]; then
        echo "Usage: webperms <path> [owner=www-data]"
        return 1
    fi

    if [ ! -e "$TARGET" ]; then
        echo "Error: Path does not exist"
        return 1
    fi

    /bin/chmod -R 775 "$TARGET"
    /bin/chown -R "$OWNER:www-data" "$TARGET"

    echo "Set permissions 775 and owner $OWNER:www-data on '$TARGET'"
}

a2pick() {
    local sites
    sites=(/etc/apache2/sites-available/*.conf)

    select site in "${sites[@]}"; do
        [ -n "$site" ] || { echo "Invalid choice"; return 1; }
        sudo a2dissite *.conf
        sudo a2ensite "$(basename "$site")"
        sudo systemctl restart apache2
        sudo apache2ctl configtest
        break
    done
}

gbranch() {
    local branches
    branches=$(git branch | sed 's/^[* ] //')

    select branch in $branches; do
        [ -n "$branch" ] || { echo "Invalid choice"; return 1; }
        git checkout "$branch"
        break
    done
}

# Script meant to drag changes from current branch to another branch
gdrag() {
    origin=$(git rev-parse --abbrev-ref HEAD);

    git checkout $1;
    git pull origin $origin;
    git push; 
    git checkout $origin; # Go back to origin at the end
}

mkcd() {
    mkdir -p "$1" && cd "$1" || return
}

extractt() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.dmg)       hdiutil mount "$1" ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.ZIP)       unzip "$1"      ;;
            *.rar)       unrar x "$1"    ;;
            *.RAR)       unrar x "$1"    ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' is not handled by extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Backup any folder quickly to timestamped tar
backupp() {
    tar -czf "$1_$(date +%F_%H-%M-%S).tar.gz" "$1";
}

# Replace string in all files recursively
rreplace() {
    grep -rl "$1" . | xargs sed -i "s/$1/$2/g";
}

# Compare two dirs visually
diffd() {
    diff -qr "$1" "$2" | less;
}

# Conventional commit helper
convc() {
    set -euo pipefail

    local TYPES=(
        "feat:A new feature"
        "fix:A bug fix"
        "docs:Documentation only"
        "style:Formatting, missing semi-colons, etc."
        "refactor:Neither fix nor feature"
        "perf:Performance improvement"
        "test:Adding or fixing tests"
        "build:Build system or dependencies"
        "ci:CI configuration"
        "chore:Other changes (no src/test)"
        "revert:Revert a previous commit"
    )

    git rev-parse --is-inside-work-tree &>/dev/null || {
        echo "Not a git repository." >&2
        return 0
    }

    if [[ -z "$(git diff --cached --name-only)" ]]; then
        read -rp "Stage all changes? [Y/n]: " yn
        [[ -z "$yn" || "$yn" =~ ^[Yy]$ ]] && git add -u
    fi

    [[ -z "$(git diff --cached --name-only)" ]] && {
        echo "Nothing to commit."
        return 0
    }

    echo ""
    for i in "${!TYPES[@]}"; do
        key="${TYPES[$i]%%:*}"
        desc="${TYPES[$i]#*:}"
        printf "%2d) %-10s %s\n" $((i+1)) "$key" "$desc"
    done

    local choice
    while true; do
        read -rp "Type [1-${#TYPES[@]}]: " choice
        [[ "$choice" =~ ^[0-9]+$ && choice -ge 1 && choice -le ${#TYPES[@]} ]] && break
    done

    local type="${TYPES[$((choice-1))]%%:*}"

    read -rp "Scope (optional): " scope

    read -rp "Breaking change? [y/N]: " yn
    [[ "$yn" =~ ^[Yy]$ ]] && bang="!" || bang=""

    local subject
    while true; do
        read -rp "Message: " subject
        [[ -n "$subject" ]] && break
    done

    if [[ -n "$scope" ]]; then
        msg="${type}(${scope})${bang}: ${subject}"
    else
        msg="${type}${bang}: ${subject}"
    fi

    echo ""
    echo "$msg"
    echo ""

    read -rp "Commit? [Y/n]: " yn
    [[ -z "$yn" || "$yn" =~ ^[Yy]$ ]] && git commit -m "$msg"
    
    read -rp "Push? [Y/n]: " yn
    [[ -z "$yn" || "$yn" =~ ^[Yy]$ ]] && git push
}

dnuke() {
    echo "WARNING: This will destroy ALL Docker containers, images, volumes, networks, and build cache."
    echo "Current state:"
    echo "  Containers: $(docker ps -aq 2>/dev/null | wc -l)"
    echo "  Images:     $(docker images -q 2>/dev/null | wc -l)"
    echo "  Volumes:    $(docker volume ls -q 2>/dev/null | wc -l)"
    echo ""
    read -rp "Type 'NUKE' to confirm: " confirm

    if [ "$confirm" != "NUKE" ]; then
        echo "Aborted."
        return 1
    fi

    docker stop $(docker ps -aq) 2>/dev/null
    docker system prune -a --volumes -f
    docker builder prune -a -f

    echo "Docker environment wiped."
}

__mysql_require_cnf() {
    local CNF="$HOME/.my.cnf"

    if [ ! -f "$CNF" ]; then
        echo "Missing $CNF"
        echo "Create it with:"
        echo ""
        echo "[client]"
        echo "user=your_user"
        echo "password=your_password"
        echo ""
        echo "Then secure it:"
        echo "chmod 600 ~/.my.cnf"
        return 1
    fi
}

sqlimport() {
    local FILE=$1
    local DB=$2

    __mysql_require_cnf || return 1

    if [ -z "$FILE" ] || [ -z "$DB" ]; then
        echo "Usage: sqlimport <sql_file.sql.gz> <database_name>"
        return 1
    fi

    mysql -e "DROP DATABASE \`${DB}\`;"
    mysql -e "CREATE DATABASE \`${DB}\` CHARACTER SET utf8 COLLATE utf8_general_ci"

    # gunzip < "${FILE}" | mysql "${DB}" # Might cause "Out of memory" error for big files, so using zcat instead
    zcat -f "${FILE}" | mysql --max_allowed_packet=512M "${DB}" # Use zcat with -f to handle both gzipped and plain sql files, and set max_allowed_packet to avoid "Packet too large" error 

    echo "Imported '${FILE}' into database '${DB}'"
}

sqlexport() {
    local DB=$1
    local OUTFILE=$2

    __mysql_require_cnf || return 1

    if [ -z "$DB" ]; then
        echo "Usage: sqlexport <database_name> <output_sql_file.sql.gz>"
        return 1
    fi

    if [ -z "$OUTFILE" ]; then
        OUTFILE="${DB}_$(date +%F_%H-%M-%S).sql.gz"
    fi

    mysqldump  --single-transaction --quick --lock-tables=false "${DB}" | gzip > "${OUTFILE}"

    echo "Exported database '${DB}' to '${OUTFILE}'"
}
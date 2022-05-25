# shellcheck disable=SC1083
parser_definition() {
    setup REST help:usage abbr:true -- \
        "Usage: ${2##*/} [command] [options...] [arguments...]"
    msg -- '' 'Options:'
    disp :usage -h --help
    disp VERSION --version

    msg -- '' 'Commands: '
    msg -- 'Use command -h for a command help.'
    cmd feather -- "Create Feathericons."
    cmd hero -- "Create Heroicons in one directory."
    cmd ion -- "Create Ionicons."
    cmd material -- "Create Material-design-icons."
    cmd simple -- "Create Simple-icons."
    cmd lucide -- "Create Lucide-icons."
    cmd flag -- "Create country flag icons."
    cmd awesome -- "Create Awesome icons."
    # cmd text_example -- "Print different type of texts."
    # cmd create -- "Create this and that."

    msg -- '' "Examples:
    
    hero 
    $SCRIPT_NAME hero
    version
    $SCRIPT_NAME --version
    Display help:
    $SCRIPT_NAME -h | --help
"
}

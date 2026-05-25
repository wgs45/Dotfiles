function coffee --description 'Netrunner ICE-Breaker: Block system sleep cycles'
    # Default to 60 minutes if no argument is passed
    set mins 60
    if test (count $argv) -gt 0
        set mins $argv[1]
    end

    # Calculate seconds
    set secs (math "$mins * 60")

    # Cyberpunk Theme UI Setup
    clear
    printf "\e[?25l" # Hide the standard cursor for a cleaner look

    echo "=== NETRUNNER DECK: INITIALIZING SLEEP_BLOCK v2.077 ===" | lolcat -f
    echo "=======================================================" | lolcat -f
    echo " [STATUS] : ICE active. Core sleep protocols overridden." | lolcat -f
    echo " [TARGET] : Maintaining terminal uplink for $mins minutes ($secs seconds)." | lolcat -f
    echo " [ALARM]  : Safe-exit sequence mapped to: [ Ctrl + C ]" | lolcat -f
    echo "=======================================================" | lolcat -f
    echo " » LINK ESTABLISHED. INJECTING CAFFEINE TO KERNEL..." | lolcat -f
    echo ""

    # Execute caffeinate in the foreground so Ctrl+C works instantly
    caffeinate -t $secs

    # Session Finish UI
    printf "\e[?25h" # Restore cursor safely
    echo ""
    echo "=== [ICE BREACHED] : UPLINK DISCONNECTED ===" | lolcat -f
    echo " -> System idle state restored. Neural link offline." | lolcat -f
end

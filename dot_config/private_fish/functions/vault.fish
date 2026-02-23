function vault --description 'Wrapper for vault to auto-login on 403 errors'
    # Run the actual vault binary with the passed arguments
    # We use 'command vault' to avoid an infinite recursion loop
    set --local output (command vault $argv 2>&1)
    set --local status_code $status

    # Check if the output contains a 403 error
    if echo $output | string match -q "*Code: 403. Errors*"
        or test $status_code -eq 2 # Some versions exit 1 on 403

        echo (set_color yellow)"403 Forbidden detected. Attempting OIDC login..."(set_color normal)

        # Execute your specific login command
        if command vault login -method=oidc 1>/dev/null 2>&1
            echo (set_color green)"Login successful. Retrying original command..."(set_color normal)
            command vault $argv
        else
            echo (set_color red)"Login failed. Please check your credentials."(set_color normal)
            return 1
        end
    else
        # If it wasn't a 403, just print the output and exit with the original status
        echo $output
        return $status_code
    end
end

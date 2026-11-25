TASK=""

hexagonal_numbers() {
    echo "Calculating hexagonal numbers"
}

square_numbers() {
    echo "Calculating square numbers"
}

quadratic_sequence() {
    echo "Calculating quadratic sequence"
}

display_task_choices() {
    echo " "
    echo "Usage: "
    echo "  Task choices (Input a letter to choose a task)"
    echo "  H, h    - Calculate hexagonal numbers"
    echo "  S, s    - Calculate square numbers"
    echo "  Q, q    - Calculate quadratic sequences"
    echo " "
    echo "  exit    - Quit the application"
    echo "  press CTRL + C to exit"
    echo " "
}

# Checks if the users task input is a valid task
validate_task() {
    local TASK_CHOICES=("H" "h" "S" "s" "Q" "q")
    local task=$1

    for i in "${TASK_CHOICES[@]}"; do
        if [ "$task" = "$i" ]; then
            # 0 = true
            return 0
        fi
    done

    # 1 = false
    return 1
}

get_task_choice() {
    display_task_choices

    while true; do
        read -p 'Task: ' task

        if [ "$task" = "exit" ]; then
            exit 0
        fi

        validate_task $task
        local is_valid=$?

        if [ $is_valid -eq 1 ]; then
            echo " "
            echo "Invalid Choice"
            display_task_choices
            continue
        fi

        TASK="$task"
        return 0
    done
}

verify() {
    local max_attempts=3
    local password="k99"

    local password_attempts=0

    while [ $max_attempts -ge $password_attempts ]; do
        read -p 'Enter Password: ' pswd
        ((password_attempts+=1))

        if [ "$pswd" = "$password" ]; then
            # 0 = true
            return 0
        else
            if [ $password_attempts -eq 2 ]; then
                echo "You have only one attempt left"
                continue
            elif [ $password_attempts -eq 3 ]; then
                echo "You are out of attempts"
                # 1 = false
                return 1
            fi
        fi
    done
}

main() {
    verify
    local is_verified=$?
    if [ $is_verified -eq 1 ]; then
        echo "User verification failed"
        exit 0
    fi

    get_task_choice
    # echo $TASK

    if [ "$TASK" = "H" ] || [ "$TASK" = "h" ]; then
        hexagonal_numbers
    elif [ "$TASK" = "S" ] || [ "$TASK" = "s" ]; then
        square_numbers
    elif [ "$TASK" = "Q" ] || [ "$TASK" = "q" ]; then
        quadratic_sequence
    fi
}

main

#!/bin/bash
# Path to the reminder file
REMINDER_FILE="$HOME/.config/eww/reminders.txt"
# Path to store the latest reminder for Eww
#!/bin/bash
# Path to the reminder file
REMINDER_FILE="$HOME/.config/eww/reminders.txt"
# Path to store the latest reminder for Eww
LATEST_REMINDER="$HOME/.config/eww/last_reminder.txt"

# Create files if they don't exist
touch "$REMINDER_FILE"
echo "No reminders yet" > "$LATEST_REMINDER"

# Log file for debugging
LOG_FILE="$HOME/.config/eww/reminder_log.txt"
echo "Daemon started at $(date)" > "$LOG_FILE"

# Main daemon loop
while true; do
    # Get current time in HH:MM format
    current_time=$(date +"%H:%M")
    echo "Checking at $current_time" >> "$LOG_FILE"
    
    # Check for matching reminders
    matched=false
    while IFS= read -r line; do
        time=$(echo "$line" | cut -d'|' -f1)
        message=$(echo "$line" | cut -d'|' -f2-)
        
        if [ "$time" = "$current_time" ]; then
            echo "Matched reminder: $message" >> "$LOG_FILE"
            notify-send "Reminder" "$message"

            # Update Eww variable
            echo "$message" > "$LATEST_REMINDER"

            # Show Eww panel
            eww open reminder-panel

            # Wait for 10 seconds, then close the panel
            sleep 10
            eww close reminder-panel
            
            matched=true
        fi
    done < "$REMINDER_FILE"

    # Remove triggered reminders if any were found
    if [ "$matched" = true ]; then
        grep -v "^$current_time|" "$REMINDER_FILE" > "${REMINDER_FILE}.new"
        mv "${REMINDER_FILE}.new" "$REMINDER_FILE"
        echo "Removed triggered reminders" >> "$LOG_FILE"
    fi

    # Wait 60 seconds before checking again
    sleep 10
done


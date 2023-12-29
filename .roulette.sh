#!/bin/bash

echo "Welcome to the Two-Player Russian Roulette Simulator!"

# Number of chambers in the gun
num_chambers=6

# Initialize player names
read -p "Enter Player 1's name: " player1
read -p "Enter Player 2's name: " player2

# Randomly load a bullet into one of the chambers
bullet_chamber=$((1 + RANDOM % num_chambers))

# Function to pull the trigger
pull_trigger() {
    local player_name="$1"

    # Display the remaining chambers
    echo "Remaining chambers: ${chambers[@]}"

    # Remove the first chamber in the list (cycling to the beginning if needed)
    local selected_chamber=${chambers[0]}
    chambers=("${chambers[@]:1}")

    # Check if the selected chamber has the bullet
    if [ "$selected_chamber" -eq "$bullet_chamber" ]; then
        echo "BANG! $player_name got the bullet. Game over!"
        exit 1
    else
        echo "Click. $player_name survived this round."
    fi
}

# Initialize chambers array
chambers=($(seq 1 $num_chambers))

# Randomly determine the starting chamber
start_chamber=$((1 + RANDOM % num_chambers))

# Rotate the chambers array to start from the randomly selected chamber
chambers=("${chambers[@]:$start_chamber}" "${chambers[@]:0:$start_chamber}")

# Pull the trigger for each player in turns
for _ in $(seq 1 $((num_chambers * 2))); do
    if [ ${#chambers[@]} -gt 0 ]; then
        read -p "$player1, press Enter to pull the trigger..."
        pull_trigger "$player1"
    fi

    if [ ${#chambers[@]} -gt 0 ]; then
        read -p "$player2, press Enter to pull the trigger..."
        pull_trigger "$player2"
    fi
done

# Inform the users that the simulation is complete
echo "Simulation complete. The gun is now empty. Game over!"

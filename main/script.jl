# Import the random module
using Random

# Define pre-defined rules and responses
responses = Dict(
    "hello" => ["Hello!", "Hi there!", "Hey!"],
    "how are you" => ["I'm just a chatbot.", "I don't have feelings, but I'm here to help."],
    "what's your name" => ["you can call me JOI."],
    "bye" => ["Goodbye!", "See you later!", "Bye!"],
    "default" => ["I'm not sure I understand.", "Can you please rephrase that?", "I don't have an answer for that."]
)

# Function to generate a response based on user input
function get_response(user_input)
    user_input = lowercase(user_input)  # Convert user input to lowercase for case-insensitive matching

    # Check if the user input matches any predefined rules
    for (rule, response_list) in responses
        if occursin(rule, user_input)
            return rand(response_list)
        end
    end

    # If no specific rule matches, use the default response
    return rand(responses["default"])
end

# Main chat loop
println("Chatbot: Hi! How can I help you today? (Type 'bye' to exit)")

while true
    print("You: ")
    user_input = readline()
    if lowercase(user_input) == "bye"
        println("Chatbot: Goodbye!")
        break
    end
    response = get_response(user_input)
    println("Chatbot: ", response)
end

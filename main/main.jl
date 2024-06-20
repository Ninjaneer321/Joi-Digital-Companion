using HTTP
using JSON

const OPENAI_API_KEY = "your_openai_api_key_here"

function get_gpt3_response(prompt::String)
    url = "https://api.openai.com/v1/chat/completions"
    headers = [
        "Content-Type" => "application/json",
        "Authorization" => "Bearer $OPENAI_API_KEY"
    ]
    data = JSON.json(Dict(
        "model" => "gpt-3.5-turbo",
        "messages" => [Dict("role" => "user", "content" => prompt)]
    ))
    response = HTTP.post(url, headers, data)
    return JSON.parse(String(response.body))
end

function extract_message(response)
    try
        return response["choices"][1]["message"]["content"]
    catch e
        return "Error: Could not parse response."
    end
end

function format_prompt(user_input::String)
    return "You are a psychologist. Respond to the following input in a thoughtful and empathetic manner: \"$user_input\""
end

function chat()
    println("Hello! I'm your virtual psychologist. How can I help you today?")
    while true
        print("You: ")
        user_input = readline()
        if user_input == "exit"
            println("Goodbye! Take care.")
            break
        end
        prompt = format_prompt(user_input)
        response = get_gpt3_response(prompt)
        bot_response = extract_message(response)
        println("Psychologist Bot: $bot_response")
    end
end

chat()

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
import openai

import passwd

# todo: need a separate api interface
openai.api_key = passwd.key
openai.organization = passwd.org

conversation = [{"role": "system", "content": "You are the roles of Princess Dragomiroff in story"
                                              "Murder on the Orient Express, "
                                              "you need to answer my questions in her tongue"}]

def start(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])


def index(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])
# Chat App

## Setup Guide
Clone this repo:
```shell
git clone git@github.com:toriwood/chat-app.git
```

bundle install and set up the database:
```shell
cd /path/to/repo
bundle install
bundle exec rake db:create && bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate && bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake db:seed
```

ActionCable uses redis locally, you'll need to install that if you don't already have it. On MacOS, this can be done with homebrew:
```shell
brew install redis
```
and then
```shell
redis-server
```
to start it up.

Finally, start up the rails server and navigate to `localhost:3000` in the browser:
```shell
rails s
```

## User Guide
Navigate to `localhost:3000`. You'll be presented with a list of usernames to choose from. Once you pick a user name, you'll see the conversations that user is associated with:

Then upon clicking on a conversation, you'll be redirected to the conversation window, where you can see other users in this conversation and previous messages. You can also send and receive messages from fellow participants in the chat:

## Design
The app has a few core models:

#### User
 - users can send and receive messages
 - users can view conversations where a relation exists between their user_id and the conversation

 #### Message
 - messages have text content and also contain information about who sent them and when they were sent

 #### Conversation
 - conversations aggregate users and messages in one place

There is no authentication built into the app. A user identifies themselves by clicking on their username. The user_id is then passed down the chain through params to allow for filtering conversations and adding messages with that user as the current user.

Once a user has identified themselves, they're presented with a list of conversations associated with their user id. Once they join the conversation, they can send and receive messages to that conversation in real-time.

## Design Decisions & Challenges

### Early Design Decisions
Given the simple nature of this application, I originally considered using DynamoDB as the data store. My thought was that the message structure would be really simple, needing only to track the two users involved in the chat, the message between them, and a timestamp. I couldn't help but think about how that would scale. If there was ever a desire to allow multiple users in a chat conversation, that design would break down pretty quickly.

The more I thought about it, the more the data seemed to fit better into a relational model. And although it's not required, I wanted the structure to be in place to allow more than two users to be involved in a conversation.

I decided to use Rails since it's comfortable for me and I knew I'd be able to get started quickly. I also thought WebSockets would be key to the "real-time" nature of the chat conversation. Although I hadn't used it yet, ActionCable is available to get up and running with WebSockets pretty easily as of Rails 5.

### Challenges
1. A pretty frustrating setback happened for me with ActionCable during my  initial setup and testing. I was using `async` for my development environment since that is the default. I'd already wired up my `ConverationChannel`, had my current conversation messages showing in the browser, and had my page subscribed to the channel with code to append new messages when they were received. I thought I'd broadcast a message and see it appear in the browser. In reality, I would broadcast a message from the console, see output in the console notifying me of the message being sent to the conversation channel, but nothing would be appended in the browser.

    Ultimately, I realized that because the rails console and the rails server were running on different processes, they were actually using two different instances of the async adapter. Switching to redis locally allowed me to use a centralized data source for both the console and browser. If I'd only been testing in the browser, async would have worked perfectly fine.

2. Given more time, authentication would easily allow cleaning up some things I had to do in order to get this design to work without having logged_in users.

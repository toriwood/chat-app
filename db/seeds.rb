hp = User.find_or_create_by(username: 'hpotter')
hg = User.find_or_create_by(username: 'hgranger')
rw = User.find_or_create_by(username: 'rweasley')

conversation1 = Conversation.find_or_create_by(id: 1)
conversation1.users = [hp, hg, rw]
conversation1.save

conversation2 = Conversation.find_or_create_by(id: 2)
conversation2.users = [rw, hg]
conversation2.save

conversation3 = Conversation.find_or_create_by(id: 3)
conversation3.users = [hp, rw]
conversation3.save

conversations = [
  [
    { user: hp, text: 'Hello, my magical friends' },
    { user: hg, text: 'Hi, friend!'},
    { user: rw, text: 'Hi :)'},
    { user: hp, text: 'I have a joke for you all'},
    { user: hg, text: 'Oh no...'},
    { user: hp, text: 'Why did Barty Crouch Jr. quit drinking?'},
    { user: hp, text: '.....'},
    { user: hp, text: 'Because it was making him Moody.'},
    { user: hg, text: 'Wow.'},
    { user: rw , text: "hahaha that's pretty clever mate..."}
  ],
  [
    { user: rw, text: 'hey, can I borrow your notes from potions today?' },
    { user: rw, text: 'I was out sick..' },
    { user: hg, text: 'Sick?? Load of rubbish if you ask me.'},
    { user: hg, text: "Sure. But this is the last time, Ronald! You've got to start being more responsible."},
  ],
  [
    { user: rw, text: "ayyy, mate.. i heard about you blowing up your aunt and i can't stop laughing" },
    { user: hp, text: "it was nuts haha" },
    { user: rw, text: "well, don't listen to hermione....it was totally worth it"},
    { user: hp, text: "haha thanks, mate..see you at practice later?"},
    { user: rw, text: "you know it!"},
  ]
]

conversations.each_with_index do |conv, i|
  conv.each do |mess_obj|
    Message.create(user_id: mess_obj[:user].id, conversation_id: i + 1, text: mess_obj[:text])
  end
end

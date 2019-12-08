$ ->
  $('div[data-conversation-id]' ).each ->
    conversationId = $(this).data('conversation-id')
    App.cable.subscriptions.create {
      channel: 'ConversationChannel'
      conversation_id: conversationId
    }, received: (data) ->
      append_message = (classname, content) ->
        $("#{classname}").append content

      format_message = (data) ->
        "<div class='message'>
          <div class='message-sender'>#{data['sender_name']} at <span class='message-timestamp'>#{data['sent_at']}</span></div>
          <div class='message-text'>#{data['message_text']}</div>
        </div>"

      append_message(".conversation-table-#{data.conversation_id}", format_message(data))

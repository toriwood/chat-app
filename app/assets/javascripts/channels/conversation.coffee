$(document).on 'turbolinks:load', ->
  $('div[data-conversation-id]').each ->
    conversationId = $(this).data('conversation-id')
    App.cable.subscriptions.create {
      channel: 'ConversationChannel'
      conversation_id: conversationId
    }, received: (data) ->
      append_message = (classname, content) ->
        $("#{classname} .messages").append content
        $("#{classname}").scrollTop($("#{classname}")[0].scrollHeight);
        $(".chat-input").val('')

      format_message = (data) ->
        "<div class='message container-sm'>
          <div>
            <span class='message-sender'>
              #{data['sender_name']}
            </span>
            at
            <span class='message-timestamp'>
              #{data['sent_at_time']} on
              #{data['sent_at_date']}
            </span>
          </div>
          <div class='message-text'>#{data['message_text']}</div>
        </div>"

      append_message(".conversation-table-#{data.conversation_id}", format_message(data))

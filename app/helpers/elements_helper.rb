module ElementsHelper
  def bulma_flash key: :flash
    return "" if flash(key).empty?
    id = (key == :flash ? "flash" : "flash-#{key}")

    messages = flash(key).collect do |type, msg|
      className = case type
      when :error
        'is-danger'
      when :warning
        'is-warning'
      when :success
        'is-success'
      when :info
        'is-info'
      else
        ''
      end
      "<div class='notification #{ className } flash #{ type }'>#{ msg }</div>"
    end

    "<div class='container' id='#{ id }'>#{ messages.join }</div>"
  end

  def react_component name, data={}
    data = data.to_json unless data.kind_of? String
   "<div class='react-component' data-react='#{ name }' data-payload='#{ data }'></div>"
  end

  def emojify text
    tokened = EmojiParser.parse text do |emoji|
      ":#{ emoji.name }:"
    end

    EmojiParser.detokenize tokened
  end
end

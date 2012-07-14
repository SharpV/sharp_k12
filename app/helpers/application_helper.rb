#encoding: utf-8

module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def author
    Struct.new(:name, :email).new(enki_config[:author][:name], enki_config[:author][:email])
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end
  
  def title_block(text, more_url=nil, more_text="更多")
    more_link = more_url ? link_to(more_text, more_url, :class=>'RouterLink') : ''
    block = <<-EOS 
    <div class="page-header clearfix">
    <h4>#{text}</h4>
    <div class='more'>
    #{more_link}
    </div>
    </div>
    EOS
  end
  
end

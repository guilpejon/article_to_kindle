require 'pony'

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => ENV['SMTP_USER'],
    :password             => ENV['SMTP_PASSWORD'],
    :authentication       => :plain
  }
}

# Kindle was using the filename as title, so..
# Clean hard spaces and other special characters
article_title = ENV['ARTICLE_TITLE'].gsub(/[^0-9A-Za-z]/, ' ')

Pony.mail(
  to: 'to@kindle.com',
  subject: 'Article',
  body: '',
  attachments: {
    "#{article_title}.pdf" => File.read('/app/article.pdf')
  }
)

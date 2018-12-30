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

Pony.mail(
    to: 'to@kindle.com',
    subject: 'Article',
    body: '',
    attachments: {
        'article.mobi' => File.read('/app/article.mobi')
    }
)
class WikiMailer < ApplicationMailer
  default from: "mario.roncador@gmail.com"

  def new_wiki(user, wiki)

    headers["Message-ID"] = "<wikis/#{wiki.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<wikis/#{wiki.id}@your-app-name.example>"
    headers["References"] = "<wikis/#{wiki.id}@your-app-name.example>"

    @user = user
    @wiki = wiki

    mail(to: "mario.roncador@icloud.com", subject: "New wiki #{wiki.title}")
  end

end

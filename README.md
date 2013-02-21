
rails new feisbuk

Create a bunch of files! Yo!

-----------------------------------

create  
create  README.rdoc
create  Rakefile
create  config.ru
create  .gitignore
create  Gemfile
create  app
create  app/assets/images/rails.png
create  app/assets/javascripts/application.js
create  app/assets/stylesheets/application.css
create  app/controllers/application_controller.rb
create  app/helpers/application_helper.rb
create  app/views/layouts/application.html.erb
create  app/mailers/.gitkeep
create  app/models/.gitkeep
create  config
create  config/routes.rb
create  config/application.rb
create  config/environment.rb
create  config/environments
create  config/environments/development.rb
create  config/environments/production.rb
create  config/environments/test.rb
create  config/initializers
create  config/initializers/backtrace_silencers.rb
create  config/initializers/inflections.rb
create  config/initializers/mime_types.rb
create  config/initializers/secret_token.rb
create  config/initializers/session_store.rb
create  config/initializers/wrap_parameters.rb
create  config/locales
create  config/locales/en.yml
create  config/boot.rb
create  config/database.yml
create  db
create  db/seeds.rb
create  doc
create  doc/README_FOR_APP
create  lib
create  lib/tasks
create  lib/tasks/.gitkeep
create  lib/assets
create  lib/assets/.gitkeep
create  log
create  log/.gitkeep
create  public
create  public/404.html
create  public/422.html
create  public/500.html
create  public/favicon.ico
create  public/index.html
create  public/robots.txt
create  script
create  script/rails
create  test/fixtures
create  test/fixtures/.gitkeep
create  test/functional
create  test/functional/.gitkeep
create  test/integration
create  test/integration/.gitkeep
create  test/unit
create  test/unit/.gitkeep
create  test/performance/browsing_test.rb
create  test/test_helper.rb
create  tmp/cache
create  tmp/cache/assets
create  vendor/assets/javascripts
create  vendor/assets/javascripts/.gitkeep
create  vendor/assets/stylesheets
create  vendor/assets/stylesheets/.gitkeep
create  vendor/plugins
create  vendor/plugins/.gitkeep
   run  bundle install

-----------------------------------

cd feisbuk/

view all files and directories with tree command on unix! enjoy! :D [ tree . ]
View, Models, Controllers, Routes and Gemfile

Maybe you need some Js library like JavaScript runtime [ExecJS::RuntimeUnavailable]
Edit Gemfile and uncomment gem 'therubyracer', :platforms => :ruby

sublime . & [ sublime and command info ]

# Gemfile
gem 'gravtastic'
gem 'bcrypt-ruby', '~> 3.0.0'

bundle install

rails server

On Firefox, http://localhost:3000. You will see the index page.
Find it on [ public folder ] and remove it.

rm public/index.html




 --> SWITCH TO SLIDES [ USERS ] <--




rails g scaffold User username:string email:string password_digest:string

Generate these lines:

-----------------------------------

invoke  active_record
create    db/migrate/20130219165217_create_users.rb
create    app/models/user.rb
invoke    test_unit
create      test/unit/user_test.rb
create      test/fixtures/users.yml
invoke  resource_route
 route    resources :users
invoke  scaffold_controller
create    app/controllers/users_controller.rb
invoke    erb
create      app/views/users
create      app/views/users/index.html.erb
create      app/views/users/edit.html.erb
create      app/views/users/show.html.erb
create      app/views/users/new.html.erb
create      app/views/users/_form.html.erb
invoke    test_unit
create      test/functional/users_controller_test.rb
invoke    helper
create      app/helpers/users_helper.rb
invoke      test_unit
create        test/unit/helpers/users_helper_test.rb
invoke  assets
invoke    coffee
create      app/assets/javascripts/users.js.coffee
invoke    scss
create      app/assets/stylesheets/users.css.scss
invoke  scss
create    app/assets/stylesheets/scaffolds.css.scss

-----------------------------------

What is active_record ? [ Switch to slides ]

rake db:migrate

Watch MVC files..

# config/routes.rb
root :to => 'users#index'

Add some bootstrap style or gangnam style of course! :)
You can do it adding the 'twitter-bootstrap-rails' gem in Gemfile or copy and paste bootstrap's files in twit/app/assets subdirectories! It's better! :D

# Gemfile
gem "less-rails"
gem "twitter-bootstrap-rails"

bundle install

rails generate bootstrap:install less
rails g bootstrap:layout application fixed -> rails g bootstrap:layout [LAYOUT_NAME] [*fixed or fluid]
rails g bootstrap:themed Users

# app/views/layouts/application.html.erb
pull-right on nav

# app/assets/stylesheets/application.css
*= require bootstrap_and_overrides
body {
	padding-top: 50px;
}

# app/assets/stylesheets/bootstrap_and_overrides.css
@linkColor: #ff0000; [ remove // ] it works! :)
@navbarBackgroundHighlight: #0000ff;
@navbarBackground: #0000ff;
@navbarText: #ffffff;
@navbarLinkColor: #ffffff;

Show a bit of Rails console.. [ Switch to terminal ]
Add User.

As you can see, email and username could be empty..

add some validates to user model:

-----------------------------------

	include Gravtastic
  before_validation :prep_email

  validates :username, :email, :password_digest, :presence => true 
  validates :username, :uniqueness => true, :length => { minimum: 3, maximum: 18 }
  validates :email, :uniqueness => true, :format => { with: /^[\w.+-]+@([\w]+.)+\w+$/ }

  has_secure_password
  has_gravatar :secure => true, :filetype => :png, :size => 120

  private

    def prep_email
        self.email = self.email.strip.downcase if self.email
    end

-----------------------------------

Change _form.html.erb in views/users folder
from 

  <div class="control-group">
    <%= f.label :password_digest, :class => 'control-label' %>
    <div class="controls">
      <%= f.text_field :password_digest, :class => 'text_field' %>
    </div>
  </div>

to

  <div class="control-group">
    <%= f.label :password, :class => 'control-label' %>
    <div class="controls">
      <%= f.password_field :password, :class => 'text_field' %>
    </div>
  </div>
  <div class="control-group">
    <%= f.label :password_confirmation, :class => 'control-label' %>
    <div class="controls">
      <%= f.password_field :password_confirmation, :class => 'text_field' %>
    </div>
  </div>

# models/user.rb
attr_accessible :password, :password_confirmation [ for MassAssignmentSecurity ]

# view/users/_form.html.erb
Add errors popups under form initialization

  <% if @user.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@user.errors.count, "error") %> prohibited this user from being saved:</h2>

      <ul>
      <% @user.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

Try now to update user/new page and insert uncorrect values: Urg! We must immediately add the style for errors! unwatchable! O.o

rm app/assets/stylesheets/scaffold.css.scss

class="alert alert-error"

Try to create a new profile with this e-mail address: m@mullenweg.com
add <%= image_tag user.gravatar_url %> on views aaaaaand Uhuh! Gravtastic works like a charm! :D





 --> SWITCH TO SLIDES [ POSTS ] <--





Now add the posts feature!

rails g scaffold Post body:text

Generate these lines:

-----------------------------------

invoke  active_record
create    db/migrate/20130219211339_create_posts.rb
create    app/models/post.rb
invoke    test_unit
create      test/unit/post_test.rb
create      test/fixtures/posts.yml
invoke  resource_route
 route    resources :posts
invoke  scaffold_controller
create    app/controllers/posts_controller.rb
invoke    erb
create      app/views/posts
create      app/views/posts/index.html.erb
create      app/views/posts/edit.html.erb
create      app/views/posts/show.html.erb
create      app/views/posts/new.html.erb
create      app/views/posts/_form.html.erb
invoke    test_unit
create      test/functional/posts_controller_test.rb
invoke    helper
create      app/helpers/posts_helper.rb
invoke      test_unit
create        test/unit/helpers/posts_helper_test.rb
invoke  assets
invoke    coffee
create      app/assets/javascripts/posts.js.coffee
invoke    scss
create      app/assets/stylesheets/posts.css.scss
invoke  scss
create    app/assets/stylesheets/scaffolds.css.scss

-----------------------------------

rake db:migrate

add some validations in Post model like this
  validates :body, :presence => true, :length => { minimum: 1, maximum: 140 }

Create some posts.

Important: add all the neccessary to make the relationship between users and posts..



 --> SWITCH TO SLIDES [ USER'S POSTS ] <--




has_many :posts in user model
belongs_to :user in post model

add related attr_accessible: 
  :posts in users
  :user_id, :created_at in posts

Add the user_id attribute to the model with rails generate migration command:
  rails generate migration add_user_id_to_posts user_id:integer
  rake db:migrate





 --> SWITCH TO SLIDES [ NESTED ROUTES  ] <--




Note: Change routes beacuse posts resources depends on user resources!
 ----
  resources :users do
    resources :posts
  end
 ----

http://localhost:3000/users/1/posts


# controllers/posts_controller.rb

Define a new private method..

  private 
    def get_user
      @user = User.find(params[:user_id])
    end

Add 
  before_filter: get_user
on top of the controller file.

Remember to change ALL Post with @user.posts for get all user's posts obviously!

# controllers/posts_controllers.rb [ Create ]
In create method change first line with this:
  @post = @user.posts.build(params[:post])
  redirect_to user_posts_path(@user)


Change all links refer to http://localhost:3000/posts

Ok, add style to pages...

# views/layouts/application.html.erb  [ edit container, remove sidebar]
-----------------------------------
<div class="container">
  <div class="row">
    <div class="span12">
      <%= bootstrap_flash %>
      <%= yield %>
    </div>
  </div><!--/row-->

  <footer>
    <p>&copy; Company 2012</p>
  </footer>

</div> <!-- /container -->
-----------------------------------

# views/users/index.html.erb  [ edit table, add post's count ]
# views/users/ ... [ change link references ]

# view/users/show.html.erb
-----------------------------------
<%- model_class = User -%>

<section id="profile">
  <div style="height: 150px;">
      <div id="userImageDiv">
          <%= image_tag @user.gravatar_url, :size => "200x200" %>
      </div>
      <div>
        <h2 id="userInfoGlob"><%= @user.username %></h2>
        <h5 id="userInfoMail"><i class="icon-envelope" style="vertical-align: middle"></i> <%= @user.email %></h5>
        <div id="userConfig" class="dropdown">
          <a data-toggle="dropdown" class="dropdown-toggle btn-link" href="#"><i class="icon-cog" style="vertical-align: middle"></i></a>
          <ul class="dropdown-menu">
            <li><%= link_to "Show written posts", user_posts_path(@user), :class => "btn-link" %>
            <li><%= link_to "Settings", edit_user_path(@user) %></li>
            <li class="divider"></li>
            <li><a href="#">Logout</a></li>
          </ul>
        </div>
    </div>
  </div>
  <div style="padding: 10px;">
  <h2>Listing <%= @user.username %>'s   posts</h2>
    <% @user.posts.each do |post| %>
      <h4><%= link_to post.body, user_post_path(@user, post), :class => "btn-link" %>
    <% end %>
  </div>
    <br/>
</section>
<br/>

<%= button_to 'Edit', edit_user_path(@user), method: :get, :class => "btn btn-primary" %>
<%= button_to 'Back', users_path, method: :get, :class => "btn btn-primary"%>
<%= button_to 'Write post', new_user_post_path(@user), method: :get, :class => "btn btn-primary"%>
-----------------------------------



# assets/stylesheets/users.css.scss
-----------------------------------

section {

  background-color: #CED1F8;
    color: #444;
    display: block;
    outline: medium none;
    margin: auto;
    width: 940px;
    margin-top: 40px;
    box-shadow: 0px 0px 3px #222;
    position: relative;

  #userInfoGlob {
    text-shadow: 0px 1px 1px #000;
      position: absolute;
      top: 10px;
      left: 240px;
  }

  #userInfoMail {
      position: absolute;
      top: 55px;
      left: 240px;
  }

}

section:first-child {
    margin-top: 140px;
    padding-left: 30px;
    padding-right: 30px;
}

#userImageDiv {
    width: 178px;
    height: 178px;
    position: absolute;
    top: -100px;
    left: 30px;
    background: #FFF;
    border: 1px solid #222;
    padding: 5px 4px;
    box-shadow: 0px 0px 2px #222;
}

#userImageDiv>img {
    vertical-align: middle;
    text-align: center;
    width: 176px;
    height: 176px;
    border: 1px solid #222;
    text-decoration: none;
    text-transform: none;
}

#userConfig {
  position: absolute;
  top: 20px;
  right: 20px;
}

-----------------------------------

# views/posts/_form.html.erb
-----------------------------------

<%= form_for([@user,@post]) do |f| %>
  <% if @post.errors.any? %>
    <div class="alert alert-error">
      <h2><%= pluralize(@post.errors.count, "error") %> prohibited this post from being saved:</h2>

      <ul>
      <% @post.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="hero-unit">
    <%= f.label :body %><br />
    <%= f.text_area :body %>
    <div class="datetimeHidden">
    <%= f.label :created_at %><br />
    <%= f.datetime_select :created_at %>
    </div>
    <div class="actions">
      <%= f.submit :class => "btn btn-primary" %>
    </div>
  </div>
<% end %>
-----------------------------------

# assets/stylesheets/posts.css.scss
-----------------------------------
.singlePost {
  padding: 10px;
  background-color: #e4e6fb;
  border: 1px solid #a2aaf0;
  border-radius: 6px;
}

.postBody {
  word-wrap:break-word;
  width: 99%;
  height: 100px;
}

.datetimeHidden {
  display: none;
}
-----------------------------------

# views/posts/index.html.erb
-----------------------------------
<% if notice%><p class="alert alert-success"><%= notice %></p><% end %>
<% if flash[:error] %><p class="alert alert-error"><%= flash[:error] %></p><% end %>

<h1>Listing <%= @user.username %>'s  posts</h1>

<table class="table table-hover table-bordered">
  <tr>
    <th>Id</th>
    <th>Content</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<% @user.posts.each do |post| %>
  <tr>
    <td><%= post.id %></td>
    <td><%= raw truncate( post.body, :length => 250, :omission => (link_to ' ..Continued', user_post_path(post.user_id, post), :class => "btn-link" ) ) %></td>
    <td><%= link_to raw('<i class="icon-home glyph"></i>'), user_post_path(post.user_id, post), :class => "btn btn-success",:title => "Show" %></td>
    <td><%= link_to raw('<i class="icon-pencil glyph"></i>'), edit_user_post_path(post.user_id, post), :class => "btn btn-primary",:title => "Edit" %></td>
    <td><%= link_to raw('<i class="icon-trash glyph"></i>'), user_post_path(post.user_id, post), :class => "btn btn-danger",:title => "Delete", method: :delete, data: { confirm: 'Are you sure?' } %></td>
  </tr>
<% end %>
</table>

<br />

<%= button_to 'New Post', new_user_post_path, method: :get, :class => "btn btn-primary"%>
-----------------------------------
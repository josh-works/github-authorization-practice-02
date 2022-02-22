

## 2022-02-22

Rebuilding https://github.com/josh-works/github_authorization_practice, because it's not working exactly right.

Something related to the encrypted files, getting them up on Heroku. It'll be fixable. 

I've also worked through:

- https://medium.com/@adamlangsner/google-oauth-rails-5-using-devise-and-omniauth-1b7fa5f72c8e
- https://johnofsydney.github.io/notes/rails/rails_social_login.html
- https://github.com/josh-works/github_authorization_practice


### Commands so far:

```
10723  rails _7.0.2_ new github_auth_practice_02
10724  gem install rails '7.0.2'
10725  which ruby
10726  rvm list
10727  rvm use 3.1.0
10728  gem list rails
10729  gem update rails
10730  rails _7.0.2_ new github-authorization-practice-02 --database postgresql --css tailwind
10731  rails _7.0.2.2_ new github-authorization-practice-02 --database postgresql --css tailwind
10732  bundle install
10733  lr
10734  cd github-authorization-practice-02
10735  atom .
```

Install devise: `gem install devise`

... detouring into getting some real data in a database, so we can do something _real_ with this new user, and associate it with real things

### Adding a `Pin` model, like a google maps pin, to use for later

```
rails g scaffold Pin title:string description:text latitude:float longitude:float
```

### add Faker and Pry Rails to Gemfile (`:production` and `:development, :test` groups respectively)

### draft some seeds:

```ruby
# seeds.rb

# i made this list of coordinates (lat and long in Golden, CO) for a different project.
cordinate_list = %w[    
  39.76622709413315,-105.22932827525855
  39.76622709413315,-105.22932827525855
  39.76507172805369,-105.22876739501953
  39.75840785139829,-105.22524833679199
  39.7467280172376,-105.22061347961427
  39.75425084928869,-105.22481918334962
  39.76071718860089,-105.22627830505371
  39.763141909318925,-105.22679328918458
  39.76485730642079,-105.2269220352173
  39.76657266078731,-105.2268147468567
]

Pin.find_or_create_by(
  description: "a dangerous intersection (at times) for everyone who uses it.",
  latitude: 39.7664442,
  longitude: -105.228456
)

Pin.find_or_create_by(
  description: "This is a dangerous street for cyclists; drivers get annoyed with cyclists, and vice versa.",
  latitude: 39.766444,
  longitude: -105.228456
)
puts "making pins"
10.times do |n|
  coords = cordinate_list.sample.split(",")
  Pin.create(
    description: Faker::Marketing.buzzwords,
    latitude: coords[0],
    longitude: coords[1]
  )
end
```

### make/seed databases

```
b rails db:create
b rails db:migrate
b rails db:seed
```


### Set root to `pins#index`

OK! We've got "just the basics" going on now, and it's nice:

![the basics](/images/just-the-basics.jpg)

### Quick detour to see if we can make this a pretty table

I don't like the default look of the page, lets see if we can make it a nice basic tailwind table

Going to use https://larainfo.com/blogs/tailwind-css-simple-table-example

![ideal outcome](/images/ideal-outcome.jpg)

So, created a new partial called `_table.html.erb`, and rendered it in the index:

```diff
diff --git a/app/views/pins/index.html.erb b/app/views/pins/index.html.erb
index c47da95..e50065d 100644
--- a/app/views/pins/index.html.erb
+++ b/app/views/pins/index.html.erb
@@ -9,6 +9,7 @@
   </div>

   <div id="pins" class="min-w-full">
+    <%= render partial: 'table' %>
     <%= render @pins %>
   </div>
 </div>
```
and I copy-pasted the big block of HTML from the `larainfo.com`  page:

```html
<div class="flex flex-col mt-8">
    <div class="py-2 -my-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
        <div class="inline-block min-w-full overflow-hidden align-middle border-b border-gray-200 shadow sm:rounded-lg">
            <table class="min-w-full">
                <thead>
                    <tr>
                        <th
                            class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50">
                            Name</th>
                        <th
                            class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50">
                            Email</th>
                        <th
                            class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50">
                            Status</th>
                        <th
                            class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50">
                            Edit</th>
                        <th
                            class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50">
                            Delete</th>
                    </tr>
                </thead>

                <tbody class="bg-white">
                    <tr>
                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 w-10 h-10">
                                    <img class="w-10 h-10 rounded-full" src="https://source.unsplash.com/user/erondu"
                                        alt="admin dashboard ui">
                                </div>

                                <div class="ml-4">
                                    <div class="text-sm font-medium leading-5 text-gray-900">
                                        John Doe
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="text-sm leading-5 text-gray-500">john@example.com</div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <span
                                class="inline-flex px-2 text-xs font-semibold leading-5 text-green-800 bg-green-100 rounded-full">Active</span>
                        </td>

                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-blue-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                        </td>
                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-red-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 w-10 h-10">
                                    <img class="w-10 h-10 rounded-full" src="https://source.unsplash.com/user/erondu"
                                        alt="admin dashboard ui">
                                </div>

                                <div class="ml-4">
                                    <div class="text-sm font-medium leading-5 text-gray-900">
                                        John Doe
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="text-sm leading-5 text-gray-500">john@example.com</div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <span
                                class="inline-flex px-2 text-xs font-semibold leading-5 text-green-800 bg-green-100 rounded-full">Active</span>
                        </td>

                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-blue-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                        </td>
                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-red-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 w-10 h-10">
                                    <img class="w-10 h-10 rounded-full" src="https://source.unsplash.com/user/erondu"
                                        alt="admin dashboard ui">
                                </div>

                                <div class="ml-4">
                                    <div class="text-sm font-medium leading-5 text-gray-900">
                                        John Doe
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <div class="text-sm leading-5 text-gray-500">john@example.com</div>
                        </td>

                        <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200">
                            <span
                                class="inline-flex px-2 text-xs font-semibold leading-5 text-green-800 bg-green-100 rounded-full">Active</span>
                        </td>

                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-blue-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                        </td>
                        <td
                            class="px-6 py-4 text-sm leading-5 text-gray-500 whitespace-no-wrap border-b border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-red-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
```

Reloaded the homepage, and it looks great!


Now lets start walking the content into something better... and voilà:

![we have a table](/images/tables.jpg)
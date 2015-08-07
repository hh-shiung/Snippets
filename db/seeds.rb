# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#This will be our master user
User.create(username: "RoRSnippet",
            first_name: "RoR",
            last_name: "Snippet",
            email: "ror@rorsnippet.com",
            password: "rorsnippet",
            avatar: Faker::Avatar.image
                 )

10.times do
   User.create(username: Faker::Internet.user_name,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               email: Faker::Internet.email,
               password: Faker::Internet.password(8),
               avatar: Faker::Avatar.image
                    )
end

  @masteruser = User.find_by(email: "ror@rorsnippet.com")
    @masteruser.snippets.create(snippet_title: 'Figure out shopify shop status',
    snippet_description: 'Figure out shopify shop status',
    snippet_content: 'begin
  ShopifyAPI::Shop.current
rescue ActiveResource::ResourceNotFound
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) appears to have gone bye bye"
  shop.destroy
rescue ActiveResource::UnauthorizedAccess => e
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) does not authorize us"
rescue ActiveResource::ForbiddenAccess => e
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) is a forbidden garden"
rescue ActiveResource::Redirection
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) bounced us"
end')

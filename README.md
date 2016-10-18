Its a basic shop application built with rails. But it has one major addition: ability to copy goods from other websites. Scraping process works real fast because of using multi threads and bulk insert to db.
- haml + bootstrap for views.
- devise + cancancan + rolify for user authorization and admin panel.
- mechanize + sidekiq for crawling.
- rspec + vcr + capybara for testing.

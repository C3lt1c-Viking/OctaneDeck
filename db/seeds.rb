# Create a main sample user.
User.create!(first_name:  "Celtic",
             last_name: "Viking",
             username: "C3lt1cViking",
             email: "c3lt1cviking90@protonmail.com",
             hobbies: "Hacking | Programming | Family Time",
             job_title: "Ruby on Rails Engineer",
             job_company: "C3lt1c Viking Operations",
             highest_education: "Doctorate of Computer Science",
             crypto_wallet_1: "34S7RQAX9kGqdGdpaym7hmdC4C2aouv8gz",
             crypto_wallet_2: "DCAhwJiqgjsXMRgRTpwzAQW4QdWd3VGpib",
             crypto_wallet_3: "0xf914c7bfA916177A433e6D7d2DA3722C29b403Ce",
             facebook: "https://www.facebook.com/",
             twitter: "https://twitter.com/C3lt1cViking",
             github: "https://github.com/C3lt1c-Viking",
             stackoverflow: "https://stackoverflow.com/users/19276054/c3lt1cviking",
             other_site: "https://www.c3lt1cviking.com",
             cell: "888-555-0505",
             marital_status: "Married",
             sex: "Robot",
             interested_in: "Friends",
             password:              "abc123",
             password_confirmation: "abc123" )

# Generate a bunch of additional users.
99.times do |n|
  first_name           = Faker::Name.first_name
  last_name            = Faker::Name.last_name
  username             = Faker::Internet.user_name
  email                = "example-#{n+1}@protonmail.com"
  job_company          = Faker::Company.name
  job_title            = Faker::Job.title
  cell                 = Faker::PhoneNumber.cell_phone
  twitter              = Faker::Internet.domain_name(domain: "twitter")
  facebook             = Faker::Internet.domain_name(domain: "facebook")
  github               = Faker::Internet.domain_name(domain: "github")
  stackoverflow        = Faker::Internet.domain_name(domain: "stackoverflow")
  other_site           = Faker::Internet.url
  highest_education    = Faker::Educator.degree
  crypto_wallet_1      = Faker::Crypto.sha256
  crypto_wallet_2      = Faker::Crypto.sha256
  crypto_wallet_3      = Faker::Crypto.sha256
  sex                  = Faker::Gender.binary_type
  interested_in        = Faker::Lorem.sentence
  hobbies              = Faker::Hobby.activity
  password             = Faker::Internet.password
  marital_status       = "Single"
  User.create!(first_name:  first_name,
               last_name: last_name,
               username: username,
               email: email,
               hobbies: hobbies,
               job_title: job_title,
               job_company: job_company,
               highest_education: highest_education,
               crypto_wallet_1: crypto_wallet_1,
               crypto_wallet_2: crypto_wallet_2,
               crypto_wallet_3: crypto_wallet_3,
               facebook: facebook,
               twitter: twitter,
               github: github,
               stackoverflow: stackoverflow,
               other_site: other_site,
               cell: cell,
               marital_status: marital_status,
               interested_in: interested_in,
               password:              password,
               password_confirmation: password)
end

Fabricator(:poster) do
  post { { body: Faker::Lorem.word, 
           twitter: (0..1).to_a.sample,
           facebook: (0..1).to_a.sample,
           linkedin: (0..1).to_a.sample,
           salesforce: (0..1).to_a.sample} }
  logins 3
end

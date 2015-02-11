class JsonData

  def self.two_products
   '[{"id":1299,
"name":"Meat Sampler (Worth $10)",
"price":5.0,
"retailer":"YourGrocer",
"created_at":"2014-01-31T13:23:13.332+11:00",
"image":"https://s3-ap-southeast-2.amazonaws.com/yg-shop-production-pictures/products/2743/mini/Meat_Sampler.jpg"},
{"id":3,
"name":"Apples Red Delicious",
"price":0.53,
"retailer":"La Manna Fresh",
"created_at":"2014-01-23T11:51:34.173+11:00",
"image":"https://s3-ap-southeast-2.amazonaws.com/yg-shop-production-pictures/products/1322/mini/data_Fruit_Apple_Red_Delicious.jpg"}]'
  end

  def self.malformed_json
    '[{"id":1299,
"name":"Meat Sampler (Worth $10)",
"price":5.0,
"retailer":"YourGrocer"},]'
  end
end

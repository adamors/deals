# Deals API

## Setup Instructions

(Assuming Ruby is installed)

1. **Install dependencies**
   ```sh
   bundle install
   ```

2. **Set up the database**
   ```sh
   bin/rails db:setup
   bin/rails db:migrate
   bin/rails db:seed
   ```

3. **Run the server**
   ```sh
   bin/rails s
   ```

4. **Run tests**
   ```sh
   bundle exec rspec
   ```

## API Usage

### Search Deals

**Endpoint:**
```
GET /deals
```

**Query Parameters:**
- `min_price` (float, optional)
- `max_price` (float, optional)
- `category_id` (integer, optional)
- `subcategory_id` (integer, optional)
- `location_id` (integer, optional)
- `user_lat` (float, optional, for ranking by distance)
- `user_lng` (float, optional, for ranking by distance)

### Example curl commands

**Get all deals:**
```sh
curl -X GET "http://localhost:3000/deals"
```

**Filter by price range:**
```sh
curl -G "http://localhost:3000/deals" --data-urlencode "min_price=20" --data-urlencode "max_price=50"
```

**Filter by category and subcategory:**
```sh
curl -G "http://localhost:3000/deals" --data-urlencode "category_id=1" --data-urlencode "subcategory_id=2"
```

**Filter by location:**
```sh
curl -G "http://localhost:3000/deals" --data-urlencode "location_id=1"
```

**Rank by proximity to user location:**
```sh
curl -G "http://localhost:3000/deals" --data-urlencode "user_lat=37.7749" --data-urlencode "user_lng=-122.4194"
```

**Combined example:**
```sh
curl -G "http://localhost:3000/deals" \
  --data-urlencode "min_price=10" \
  --data-urlencode "max_price=100" \
  --data-urlencode "category_id=1" \
  --data-urlencode "location_id=1" \
  --data-urlencode "user_lat=37.7749" \
  --data-urlencode "user_lng=-122.4194"
```


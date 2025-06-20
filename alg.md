### Scoring algorithm


- Weights:
    - Discount percentage: 2x
    - Merchant rating: 5x
    - Popularity: 0.1x
- Penalties:
    - distance (if user latitude/longitude are provided, subtracts the minimum distance in km from the score)
